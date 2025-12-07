import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';
import '../models/task_package.dart';
import '../models/task.dart';
import '../models/completion_config.dart';
import '../models/category_match_result.dart';
import '../services/json_loader.dart';
import '../services/category_detection_service.dart';
import '../services/notification_service.dart';

class DreamState extends ChangeNotifier {
  String? dreamText;
  String? categoryId;
  int currentDay = 1; // 1..30
  List<int> completedTasks = [];
  String activePackageId = 'A';
  DateTime? startDate;
  DateTime? lastCompletedDate; // Son tamamlanan görev tarihi (streak için)

  // Yüklenen veriler
  List<DreamCategory> categories = [];
  Map<String, List<String>> keywords = {};
  Map<String, Map<String, TaskPackage>> taskPackages =
      {}; // categoryId -> packageId -> TaskPackage
  Map<String, List<Map<String, String>>> motivationalMessages = {}; // categoryId -> List<{tr, en, de}>
  Map<String, CompletionConfig> completionConfigs = {};

  bool isInitialized = false;

  Future<void> initialize() async {
    try {
      // Tüm JSON verilerini JsonLoader ile yükle
      categories = await JsonLoader.loadCategories();
      keywords = await JsonLoader.loadKeywords();
      taskPackages = await JsonLoader.loadTaskPackages();
      motivationalMessages = await JsonLoader.loadMotivationalMessages();
      completionConfigs = await JsonLoader.loadCompletionConfigs();

      // Load keywords V3 for CategoryDetectionService
      final keywordsV3 = await JsonLoader.loadKeywordsV3();
      CategoryDetectionService.setKeywordsV3(keywordsV3);

      isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('DreamState başlatılırken hata: $e');
      rethrow;
    }
  }

  Future<void> setDream(String dream) async {
    dreamText = dream;

    // Detect category using V3 Hyper-Smart engine
    final matchResult = await _detectCategory(dream);
    categoryId = matchResult.category;

    debugPrint(
        'setDream: dream="$dream", detected categoryId="$categoryId", confidence=${matchResult.confidence}');
    debugPrint('setDream: scores=${matchResult.scores}');
    debugPrint(
        'setDream: isInitialized=$isInitialized, taskPackages.isEmpty=${taskPackages.isEmpty}');

    // Eğer henüz initialize edilmemişse, kullanıcıyı bilgilendir
    if (!isInitialized || taskPackages.isEmpty) {
      debugPrint(
          'setDream: Warning - taskPackages not loaded yet. Category detection may work but tasks may not be available.');
    }

    currentDay = 1;
    completedTasks = [];
    activePackageId = 'A';
    startDate = DateTime.now();
    lastCompletedDate = null;

    // Günlük bildirimi planla
    NotificationService.scheduleDailyReminder(dreamText: dream);

    notifyListeners();
    _saveToLocal();
  }

  /// Reset dream - clears all dream-related state and local storage
  /// This allows user to start a completely new dream cycle
  Future<void> resetDream() async {
    debugPrint('resetDream: Clearing all dream state');

    // Clear all state variables
    dreamText = null;
    categoryId = null;
    currentDay = 1;
    completedTasks = [];
    activePackageId = 'A';
    startDate = null;
    lastCompletedDate = null;

    // Clear all SharedPreferences keys related to dream
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('dreamText');
      await prefs.remove('categoryId');
      await prefs.remove('currentDay');
      await prefs.remove('activePackageId');
      await prefs.remove('completedTasks');
      await prefs.remove('startDate');
      await prefs.remove('lastCompletedDate');

      debugPrint('resetDream: All SharedPreferences keys cleared');
    } catch (e) {
      debugPrint('resetDream: Error clearing SharedPreferences: $e');
    }

    // Cancel any scheduled notifications
    try {
      await NotificationService.cancelAllNotifications();
      debugPrint('resetDream: All notifications cancelled');
    } catch (e) {
      debugPrint('resetDream: Error cancelling notifications: $e');
    }

    notifyListeners();
    debugPrint('resetDream: Dream reset complete');
  }

  Future<CategoryMatchResult> _detectCategory(String dream) async {
    // CategoryDetectionService V3 Hyper-Smart kullanarak kategori tespit et
    return await CategoryDetectionService.detectCategory(dream);
  }

  /// Bugün tamamlanıp tamamlanmadığını kontrol eder
  /// Production'da her gün sadece bir kez tamamlanabilir
  bool get isTodayCompleted {
    if (lastCompletedDate == null) return false;

    final now = DateTime.now();
    final lastCompleted = lastCompletedDate!;

    // Aynı gün içinde mi kontrol et (yıl, ay, gün)
    final isSameDay = now.year == lastCompleted.year &&
        now.month == lastCompleted.month &&
        now.day == lastCompleted.day;

    // Eğer bugün tamamlanmışsa (lastCompletedDate bugünün tarihiyle aynıysa)
    // ve completedTasks içinde bugünkü görev numarası varsa
    if (isSameDay) {
      // currentDay tamamlandığında bir sonraki güne geçiyor,
      // bu yüzden bugünkü görev numarası currentDay - 1
      final todayTaskNumber = currentDay - 1;
      return completedTasks.contains(todayTaskNumber);
    }

    return false;
  }

  /// Bugünkü görevi tamamla
  /// Test ortamında her zaman çalışır, production'da sadece bugün tamamlanmamışsa çalışır
  bool completeTodayTask() {
    // Test ortamında her zaman çalış
    if (kDebugMode) {
      completedTasks.add(currentDay);
      lastCompletedDate = DateTime.now();
      currentDay++;
      _updateActivePackage();
      _saveToLocal();
      notifyListeners();
      return true;
    }

    // Production: Bugün zaten tamamlanmışsa, tekrar tamamlanamaz
    if (isTodayCompleted) {
      return false;
    }

    completedTasks.add(currentDay);
    lastCompletedDate = DateTime.now();
    currentDay++;
    _updateActivePackage();
    _saveToLocal();
    notifyListeners();

    // Her 30 günde bir completion modal gösterilecek (dashboard'da kontrol edilir)
    return true;
  }

  /// Belirli bir günü tamamla (task list ekranından kullanım için)
  /// Test ortamında: Sadece bugünkü görev veya önceki görevler tamamlanabilir
  /// Production'da: Sadece bugünkü görev tamamlanabilir
  bool completeTask(int dayNumber) {
    // Production'da sadece bugünkü görev tamamlanabilir
    if (kReleaseMode && dayNumber != currentDay) {
      return false;
    }

    // Gelecekteki görevler tamamlanamaz
    if (dayNumber > currentDay) {
      return false;
    }

    // Zaten tamamlanmış görevler tekrar tamamlanamaz
    if (completedTasks.contains(dayNumber)) {
      return false;
    }

    // Görevi tamamla
    completedTasks.add(dayNumber);
    completedTasks.sort(); // Sıralı tut

    // Eğer bugünkü görev tamamlandıysa, günü ilerlet
    if (dayNumber == currentDay) {
      lastCompletedDate = DateTime.now();
      currentDay++;
      _updateActivePackage();
    } else {
      // Geçmiş bir görev tamamlandıysa (sadece test ortamında), sadece lastCompletedDate'i güncelle
      // (streak hesaplaması için)
      if (lastCompletedDate == null ||
          dayNumber > _getDayFromDate(lastCompletedDate!)) {
        lastCompletedDate = DateTime.now();
      }
    }

    _saveToLocal();
    notifyListeners();
    return true;
  }

  /// Tarihten gün numarasını hesapla (startDate'e göre)
  int _getDayFromDate(DateTime date) {
    if (startDate == null) return 0;
    return date.difference(startDate!).inDays + 1;
  }

  void _updateActivePackage() {
    if (categoryId == null) return;

    final categoryPackages = taskPackages[categoryId!];
    if (categoryPackages == null || categoryPackages.isEmpty) return;

    // 30 günlük döngüler: Her 30 günde bir paket değişir
    // Döngü numarası: (currentDay - 1) ~/ 30 + 1
    // Paket seçimi: Döngü numarasına göre A, B, C, A, B, C...
    final cycleNumber = ((currentDay - 1) ~/ 30) + 1;
    final availablePackages = categoryPackages.keys.toList()..sort();

    if (availablePackages.isNotEmpty) {
      // Döngü numarasına göre paket seç (A, B, C, A, B, C...)
      final packageIndex = (cycleNumber - 1) % availablePackages.length;
      activePackageId = availablePackages[packageIndex];
    }
  }

  /// Mevcut döngüyü sıfırla (yeni döngüye başla)
  /// Toplam gün sayısını korur, sadece döngü içindeki tamamlanan görevleri temizler
  void resetProgress() {
    // Mevcut döngünün başlangıç gününü hesapla
    final cycleStartDay = ((currentDay - 1) ~/ 30) * 30 + 1;

    // Sadece mevcut döngüdeki tamamlanan görevleri temizle
    completedTasks
        .removeWhere((day) => day >= cycleStartDay && day < currentDay);

    // Yeni döngüye başla (döngü başlangıç gününe git)
    currentDay = cycleStartDay;
    _updateActivePackage();
    _saveToLocal();
    notifyListeners();
  }

  /// 30 günlük döngü tamamlandı mı? (Her 30 günde bir true döner)
  bool get isCycleFinished {
    // 30, 60, 90, 120... günlerde true döner
    return currentDay > 1 && (currentDay - 1) % 30 == 0;
  }

  /// Mevcut döngü numarası (1, 2, 3, ...)
  int get currentCycleNumber => ((currentDay - 1) ~/ 30) + 1;

  /// Mevcut döngüdeki gün numarası (1-30)
  int get dayInCurrentCycle => ((currentDay - 1) % 30) + 1;

  /// Bugünkü görevi döndürür (Task objesi)
  Task? get todayTask {
    return getTaskForDay(currentDay);
  }

  /// Belirli bir gün için görevi döndürür (Task objesi)
  /// dayNumber: 1'den başlayan mutlak gün numarası (currentDay gibi)
  Task? getTaskForDay(int dayNumber) {
    if (categoryId == null) {
      debugPrint('getTaskForDay: categoryId is null');
      return null;
    }

    final categoryPackages = taskPackages[categoryId!];
    if (categoryPackages == null || categoryPackages.isEmpty) {
      debugPrint('getTaskForDay: No packages found for category: $categoryId');
      return null;
    }

    // Gün numarasına göre döngü ve paket hesapla
    final cycleNumber = ((dayNumber - 1) ~/ 30) + 1;
    final dayInCycle = ((dayNumber - 1) % 30) + 1;
    
    // Döngü numarasına göre paket seç (A, B, C, A, B, C...)
    final availablePackages = categoryPackages.keys.toList()..sort();
    if (availablePackages.isEmpty) {
      debugPrint('getTaskForDay: No available packages');
      return null;
    }
    
    final packageIndex = (cycleNumber - 1) % availablePackages.length;
    final packageId = availablePackages[packageIndex];
    
    final pkg = categoryPackages[packageId];
    if (pkg == null) {
      debugPrint(
          'getTaskForDay: Package "$packageId" not found for category: $categoryId');
      return null;
    }

    // Paket içindeki görev indeksini hesapla (30 günlük döngü)
    final taskIndex = dayInCycle - 1;

    if (taskIndex < 0 || taskIndex >= pkg.tasks.length) {
      debugPrint(
          'getTaskForDay: Invalid taskIndex: $taskIndex (tasks.length: ${pkg.tasks.length}, dayNumber: $dayNumber)');
      return null;
    }
    return pkg.tasks[taskIndex];
  }

  /// Get motivational message for today in specified language
  String? getTodayMotivationalMessage(String languageCode) {
    if (categoryId == null) {
      debugPrint('todayMotivationalMessage: categoryId is null');
      return null;
    }
    final list = motivationalMessages[categoryId!];
    if (list == null || list.isEmpty) {
      debugPrint(
          'todayMotivationalMessage: No messages found for category: $categoryId. Available categories: ${motivationalMessages.keys.toList()}');
      return null;
    }
    // Orijinal listeyi değiştirmemek için kopya oluştur
    final shuffledList = List<Map<String, String>>.from(list);
    shuffledList.shuffle();
    final messageMap = shuffledList.first;
    // Get message in specified language, fallback to Turkish, then English
    return messageMap[languageCode] ?? messageMap['tr'] ?? messageMap['en'];
  }

  /// Get motivational message for today (uses default language - Turkish)
  /// @deprecated Use getTodayMotivationalMessage(String languageCode) instead
  String? get todayMotivationalMessage {
    return getTodayMotivationalMessage('tr');
  }

  CompletionConfig? get currentCompletionConfig {
    if (categoryId == null) return null;
    return completionConfigs[categoryId!];
  }

  /// Mevcut kategori bilgisini döndürür
  DreamCategory? get currentCategory {
    if (categoryId == null || categories.isEmpty) return null;
    try {
      return categories.firstWhere(
        (cat) => cat.id == categoryId,
      );
    } catch (e) {
      // Kategori bulunamazsa null döndür
      return null;
    }
  }

  /// Üst üste tamamlanan gün sayısı (streak)
  int get currentStreak {
    if (completedTasks.isEmpty || startDate == null) return 0;

    // Tamamlanan görevleri tarihe göre sırala
    final sortedDays = completedTasks.toList()..sort();
    if (sortedDays.isEmpty) return 0;

    // Bugünün gün numarasını hesapla
    final today = DateTime.now();
    final daysSinceStart = today.difference(startDate!).inDays + 1;

    // Streak hesapla (son tamamlanan günlerden itibaren)
    int streak = 0;
    int checkDay = daysSinceStart;

    // Bugünden geriye doğru kontrol et
    while (checkDay > 0) {
      if (completedTasks.contains(checkDay)) {
        streak++;
        checkDay--;
      } else {
        break;
      }
    }

    return streak;
  }

  /// Toplam tamamlanan gün sayısı
  int get totalCompletedDays => completedTasks.length;

  /// İlerleme yüzdesi (0-100) - Mevcut 30 günlük döngüdeki ilerleme
  double get progressPercentage {
    return (dayInCurrentCycle / 30) * 100;
  }

  /// Kaç gün devam ediyor
  int get daysActive {
    if (startDate == null) return 0;
    return DateTime.now().difference(startDate!).inDays + 1;
  }

  /// Bu hafta tamamlanan gün sayısı (gerçek takvim haftası)
  int get thisWeekCompleted {
    if (startDate == null || completedTasks.isEmpty) return 0;

    final now = DateTime.now();
    // Bu haftanın başlangıcı (Pazartesi) - sadece tarih
    final weekStart = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
    // Bu haftanın sonu (Pazar) - sadece tarih
    final weekEnd = weekStart.add(const Duration(days: 6));

    // Tamamlanan görevlerin gerçek tarihlerini kontrol et
    return completedTasks.where((dayNumber) {
      // Bu görevin tamamlanma tarihini hesapla
      final taskDate = startDate!.add(Duration(days: dayNumber - 1));
      // Sadece tarih kısmını al (saat bilgisini yok say)
      final taskDateOnly =
          DateTime(taskDate.year, taskDate.month, taskDate.day);
      final weekStartOnly =
          DateTime(weekStart.year, weekStart.month, weekStart.day);
      final weekEndOnly = DateTime(weekEnd.year, weekEnd.month, weekEnd.day);

      // Bu hafta içinde mi kontrol et (>= weekStart ve <= weekEnd)
      return !taskDateOnly.isBefore(weekStartOnly) &&
          !taskDateOnly.isAfter(weekEndOnly);
    }).length;
  }

  /// Bu ay tamamlanan gün sayısı (gerçek takvim ayı)
  int get thisMonthCompleted {
    if (startDate == null || completedTasks.isEmpty) return 0;

    final now = DateTime.now();

    // Tamamlanan görevlerin gerçek tarihlerini kontrol et
    return completedTasks.where((dayNumber) {
      // Bu görevin tamamlanma tarihini hesapla
      final taskDate = startDate!.add(Duration(days: dayNumber - 1));

      // Bu ay içinde mi kontrol et (aynı yıl ve ay)
      return taskDate.year == now.year && taskDate.month == now.month;
    }).length;
  }

  // Local storage helpers
  Future<void> loadFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      dreamText = prefs.getString('dreamText');
      categoryId = prefs.getString('categoryId');
      currentDay = prefs.getInt('currentDay') ?? 1;
      activePackageId = prefs.getString('activePackageId') ?? 'A';

      // Load completed tasks
      final completedTasksString = prefs.getString('completedTasks');
      if (completedTasksString != null) {
        completedTasks = completedTasksString
            .split(',')
            .where((s) => s.isNotEmpty)
            .map((s) => int.tryParse(s) ?? 0)
            .where((i) => i > 0)
            .toList();
      }

      // Load start date
      final startDateMillis = prefs.getInt('startDate');
      if (startDateMillis != null) {
        startDate = DateTime.fromMillisecondsSinceEpoch(startDateMillis);
      }

      // Load last completed date
      final lastCompletedMillis = prefs.getInt('lastCompletedDate');
      if (lastCompletedMillis != null) {
        lastCompletedDate =
            DateTime.fromMillisecondsSinceEpoch(lastCompletedMillis);
      }

      // Aktif paketi güncelle
      _updateActivePackage();

      // Eğer dream varsa bildirimi planla
      if (dreamText != null && dreamText!.isNotEmpty) {
        NotificationService.scheduleDailyReminder(dreamText: dreamText!);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading from local storage: $e');
    }
  }

  Future<void> _saveToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (dreamText != null) {
        await prefs.setString('dreamText', dreamText!);
      } else {
        await prefs.remove('dreamText');
      }

      if (categoryId != null) {
        await prefs.setString('categoryId', categoryId!);
      } else {
        await prefs.remove('categoryId');
      }

      await prefs.setInt('currentDay', currentDay);
      await prefs.setString('activePackageId', activePackageId);

      // Save completed tasks as comma-separated string
      if (completedTasks.isNotEmpty) {
        await prefs.setString('completedTasks', completedTasks.join(','));
      } else {
        await prefs.remove('completedTasks');
      }

      // Save start date
      if (startDate != null) {
        await prefs.setInt('startDate', startDate!.millisecondsSinceEpoch);
      } else {
        await prefs.remove('startDate');
      }

      // Save last completed date
      if (lastCompletedDate != null) {
        await prefs.setInt(
            'lastCompletedDate', lastCompletedDate!.millisecondsSinceEpoch);
      } else {
        await prefs.remove('lastCompletedDate');
      }
    } catch (e) {
      debugPrint('Error saving to local storage: $e');
    }
  }
}

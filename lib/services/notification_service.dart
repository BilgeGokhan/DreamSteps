import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Günlük bildirim servisi
/// 
/// Kullanıcıya her gün görev hatırlatması gönderir.
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// Bildirim servisini başlatır
  static Future<void> initialize() async {
    // Timezone verilerini yükle
    tz.initializeTimeZones();

    // Android ayarları
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS ayarları
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initialization settings
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Bildirimleri başlat
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Android için kanal oluştur
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'dreamsteps_daily', // id
      'Günlük Hatırlatmalar', // name
      description: 'Günlük görev hatırlatmaları için bildirimler',
      importance: Importance.high,
      playSound: true,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    debugPrint('NotificationService: Initialized');
  }

  /// Bildirime tıklandığında çağrılır
  static void _onNotificationTapped(NotificationResponse response) {
    debugPrint('NotificationService: Notification tapped: ${response.payload}');
    // Burada uygulamayı açabilir veya belirli bir ekrana yönlendirebilirsiniz
  }

  /// Günlük bildirimi planlar (her gün saat 09:00'da)
  static Future<void> scheduleDailyReminder({
    String? dreamText,
    int hour = 9,
    int minute = 0,
  }) async {
    // Mevcut bildirimleri iptal et
    await cancelAllNotifications();

    if (dreamText == null || dreamText.isEmpty) {
      debugPrint('NotificationService: No dream set, skipping notification');
      return;
    }

    // Her gün tekrarlanan bildirim
    await _notifications.zonedSchedule(
      0, // notification id
      'Bugünün Görevi Sizi Bekliyor! 🎯',
      'Hayalinize bir adım daha yaklaşın: $dreamText',
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dreamsteps_daily',
          'Günlük Hatırlatmalar',
          channelDescription: 'Günlük görev hatırlatmaları için bildirimler',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    debugPrint(
        'NotificationService: Daily reminder scheduled for $hour:$minute');
  }

  /// Belirli bir saat için bir sonraki zamanı hesaplar
  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Eğer bugünün saati geçtiyse, yarın için planla
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  /// Tüm bildirimleri iptal eder
  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
    debugPrint('NotificationService: All notifications cancelled');
  }

  /// Bildirimi test eder (hemen gönderir)
  static Future<void> showTestNotification() async {
    await _notifications.show(
      999,
      'Test Bildirimi',
      'Bildirimler çalışıyor! 🎉',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'dreamsteps_daily',
          'Günlük Hatırlatmalar',
          channelDescription: 'Günlük görev hatırlatmaları için bildirimler',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}



import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'tr': {
      // Dream Input Screen
      'dream_input_title': 'Hayalin Nedir?',
      'dream_input_subtitle': 'Hayalini yaz, sana özel adımları oluşturalım',
      'dream_input_hint': 'Örneğin: Porsche Taycan almak istiyorum...',
      'dream_input_button': 'Adımlarımı Oluştur',
      'dream_input_error': 'Lütfen hayalinizi yazın',
      'dream_input_error_general': 'Bir hata oluştu: ',
      'dream_input_loading': 'Görev yükleniyor...',
      
      // Splash Screen
      'splash_app_name': 'DreamSteps',
      'splash_loading_timeout': 'JSON yükleme zaman aşımına uğradı',
      
      // Language Selection
      'language_selection_title': 'Dil Seçin',
      'language_selection_subtitle': 'Uygulamayı hangi dilde kullanmak istersiniz?',
      'language_turkish': 'Türkçe',
      'language_english': 'English',
      'language_german': 'Deutsch',
      
      // Dashboard
      'dashboard_change_dream': 'Hayali Değiştir',
      'dashboard_today_task': 'Bugünün Görevi',
      'dashboard_mark_completed': 'Tamamlandı Olarak İşaretle',
      'dashboard_task_completed': 'Görev tamamlandı! 🎉',
      'dashboard_task_already_completed': 'Bu görev bugün zaten tamamlandı.',
      'dashboard_cycle_day': 'Döngü - Gün',
      'dashboard_statistics': 'İstatistikler',
      'dashboard_all_steps': 'Tüm Adımlar',
      
      // Statistics
      'statistics_title': 'İstatistikler',
      'statistics_about': 'Hakkında',
      'statistics_no_dream': 'Henüz bir hayal belirlenmemiş',
      'statistics_streak': 'Üst Üste Tamamlanan Gün',
      'statistics_total_completed': 'Toplam Tamamlanan',
      'statistics_this_week': 'Bu Hafta',
      'statistics_this_month': 'Bu Ay',
      'statistics_total_time': 'Toplam Süre',
      'statistics_days_active': 'gündür devam ediyor',
      'statistics_day': 'gün',
      'statistics_great_job': 'Harika Gidiyorsun!',
      'statistics_streak_message': 'gün üst üste tamamladın! Devam et! 💪',
      'statistics_first_step': 'İlk adımı at, sonrası gelecek! 🚀',
      'statistics_progress': 'Genel İlerleme',
      'statistics_cycle': 'Döngü • Gün',
      
      // All Steps
      'all_steps_title': 'Tüm Adımlar',
      'all_steps_no_dream': 'Henüz bir hayal belirlenmemiş',
      'all_steps_no_completed': 'Henüz tamamlanan görev yok',
      'all_steps_no_completed_subtitle': 'Görevleri tamamladıkça burada görünecek',
      'all_steps_day': 'Gün',
      
      // Task Detail
      'task_detail_title': 'Günün Görevi',
      'task_detail_today_task': 'Bugünün Görevi',
      'task_detail_detail': 'Detay',
      'task_detail_motivational': 'Küçük adımlar büyük hayallere götürür. Bugünkü görevi tamamladığında bir adım daha yaklaşmış olacaksın! 💪',
      
      // About
      'about_title': 'Hakkında',
      'about_version': 'Versiyon',
      'about_build_number': 'Build Number',
      'about_package_name': 'Package Name',
      'about_description_title': 'Hakkında',
      'about_description': 'DreamSteps, hayallerinizi gerçeğe dönüştürmek için tasarlanmış bir uygulamadır. Her gün küçük adımlar atarak büyük hedeflerinize ulaşın.',
      
      // Onboarding
      'onboarding_skip': 'Atla',
      'onboarding_continue': 'Devam Et',
      'onboarding_start': 'Başlayalım',
      'onboarding_page1_title': 'Hayallerine Adım At',
      'onboarding_page1_description': 'Her büyük yolculuk küçük adımlarla başlar.',
      'onboarding_page2_title': 'Her Gün Bir Adım',
      'onboarding_page2_description': 'Günde sadece bir küçük adım, 30 günde büyük değişim.',
      'onboarding_page3_title': 'Yolculuğuna Hazır mısın?',
      'onboarding_page3_description': 'Hayalini yaz, adımlarını belirle ve başla!',
      
      // Reset Dream Dialog
      'reset_dream_title': 'Hayali Değiştir',
      'reset_dream_message': 'Mevcut hayalinizi değiştirmek istediğinizden emin misiniz?',
      'reset_dream_warning': 'Bu işlem şunları silecek:',
      'reset_dream_item1': '• Mevcut hayal ve kategori',
      'reset_dream_item2': '• Tüm ilerleme ve tamamlanan görevler',
      'reset_dream_item3': '• Başlangıç tarihi ve istatistikler',
      'reset_dream_footer': 'Yeni bir hayal ile baştan başlayacaksınız.',
      'reset_dream_cancel': 'İptal',
      'reset_dream_confirm': 'Evet, Değiştir',
      
      // Completion Modal
      'completion_modal_continue': 'Devam Et',
      'completion_modal_congrats': 'Tebrikler! 🎉',
      'completion_modal_cycle_completed': '30 günlük döngüyü tamamladın!',
    },
    'en': {
      // Dream Input Screen
      'dream_input_title': 'What is Your Dream?',
      'dream_input_subtitle': 'Write your dream, let\'s create personalized steps for you',
      'dream_input_hint': 'For example: I want to buy a Porsche Taycan...',
      'dream_input_button': 'Create My Steps',
      'dream_input_error': 'Please write your dream',
      'dream_input_error_general': 'An error occurred: ',
      'dream_input_loading': 'Loading task...',
      
      // Splash Screen
      'splash_app_name': 'DreamSteps',
      'splash_loading_timeout': 'JSON loading timeout',
      
      // Language Selection
      'language_selection_title': 'Select Language',
      'language_selection_subtitle': 'In which language would you like to use the app?',
      'language_turkish': 'Türkçe',
      'language_english': 'English',
      'language_german': 'Deutsch',
      
      // Dashboard
      'dashboard_change_dream': 'Change Dream',
      'dashboard_today_task': 'Today\'s Task',
      'dashboard_mark_completed': 'Mark as Completed',
      'dashboard_task_completed': 'Task completed! 🎉',
      'dashboard_task_already_completed': 'This task has already been completed today.',
      'dashboard_cycle_day': 'Cycle - Day',
      'dashboard_statistics': 'Statistics',
      'dashboard_all_steps': 'All Steps',
      
      // Statistics
      'statistics_title': 'Statistics',
      'statistics_about': 'About',
      'statistics_no_dream': 'No dream has been set yet',
      'statistics_streak': 'Consecutive Days Completed',
      'statistics_total_completed': 'Total Completed',
      'statistics_this_week': 'This Week',
      'statistics_this_month': 'This Month',
      'statistics_total_time': 'Total Time',
      'statistics_days_active': 'days active',
      'statistics_day': 'day',
      'statistics_great_job': 'Great Job!',
      'statistics_streak_message': 'days in a row! Keep it up! 💪',
      'statistics_first_step': 'Take the first step, the rest will follow! 🚀',
      'statistics_progress': 'Overall Progress',
      'statistics_cycle': 'Cycle • Day',
      
      // All Steps
      'all_steps_title': 'All Steps',
      'all_steps_no_dream': 'No dream has been set yet',
      'all_steps_no_completed': 'No completed tasks yet',
      'all_steps_no_completed_subtitle': 'Completed tasks will appear here',
      'all_steps_day': 'Day',
      
      // Task Detail
      'task_detail_title': 'Today\'s Task',
      'task_detail_today_task': 'Today\'s Task',
      'task_detail_detail': 'Detail',
      'task_detail_motivational': 'Small steps lead to big dreams. When you complete today\'s task, you\'ll be one step closer! 💪',
      
      // About
      'about_title': 'About',
      'about_version': 'Version',
      'about_build_number': 'Build Number',
      'about_package_name': 'Package Name',
      'about_description_title': 'About',
      'about_description': 'DreamSteps is an app designed to turn your dreams into reality. Reach your big goals by taking small steps every day.',
      
      // Onboarding
      'onboarding_skip': 'Skip',
      'onboarding_continue': 'Continue',
      'onboarding_start': 'Get Started',
      'onboarding_page1_title': 'Take Steps to Your Dreams',
      'onboarding_page1_description': 'Every great journey begins with small steps.',
      'onboarding_page2_title': 'One Step Every Day',
      'onboarding_page2_description': 'Just one small step a day, big change in 30 days.',
      'onboarding_page3_title': 'Ready for Your Journey?',
      'onboarding_page3_description': 'Write your dream, set your steps and start!',
      
      // Reset Dream Dialog
      'reset_dream_title': 'Change Dream',
      'reset_dream_message': 'Are you sure you want to change your current dream?',
      'reset_dream_warning': 'This action will delete:',
      'reset_dream_item1': '• Current dream and category',
      'reset_dream_item2': '• All progress and completed tasks',
      'reset_dream_item3': '• Start date and statistics',
      'reset_dream_footer': 'You will start over with a new dream.',
      'reset_dream_cancel': 'Cancel',
      'reset_dream_confirm': 'Yes, Change',
      
      // Completion Modal
      'completion_modal_continue': 'Continue',
      'completion_modal_congrats': 'Congratulations! 🎉',
      'completion_modal_cycle_completed': 'You completed the 30-day cycle!',
    },
    'de': {
      // Dream Input Screen
      'dream_input_title': 'Was ist dein Traum?',
      'dream_input_subtitle': 'Schreibe deinen Traum, wir erstellen dir persönliche Schritte',
      'dream_input_hint': 'Zum Beispiel: Ich möchte einen Porsche Taycan kaufen...',
      'dream_input_button': 'Meine Schritte erstellen',
      'dream_input_error': 'Bitte schreibe deinen Traum',
      'dream_input_error_general': 'Ein Fehler ist aufgetreten: ',
      'dream_input_loading': 'Aufgabe wird geladen...',
      
      // Splash Screen
      'splash_app_name': 'DreamSteps',
      'splash_loading_timeout': 'JSON-Ladezeit überschritten',
      
      // Language Selection
      'language_selection_title': 'Sprache auswählen',
      'language_selection_subtitle': 'In welcher Sprache möchtest du die App verwenden?',
      'language_turkish': 'Türkçe',
      'language_english': 'English',
      'language_german': 'Deutsch',
      
      // Dashboard
      'dashboard_change_dream': 'Traum ändern',
      'dashboard_today_task': 'Heutige Aufgabe',
      'dashboard_mark_completed': 'Als erledigt markieren',
      'dashboard_task_completed': 'Aufgabe erledigt! 🎉',
      'dashboard_task_already_completed': 'Diese Aufgabe wurde heute bereits erledigt.',
      'dashboard_cycle_day': 'Zyklus - Tag',
      'dashboard_statistics': 'Statistiken',
      'dashboard_all_steps': 'Alle Schritte',
      
      // Statistics
      'statistics_title': 'Statistiken',
      'statistics_about': 'Über',
      'statistics_no_dream': 'Noch kein Traum festgelegt',
      'statistics_streak': 'Aufeinanderfolgende Tage abgeschlossen',
      'statistics_total_completed': 'Gesamt abgeschlossen',
      'statistics_this_week': 'Diese Woche',
      'statistics_this_month': 'Dieser Monat',
      'statistics_total_time': 'Gesamtzeit',
      'statistics_days_active': 'Tage aktiv',
      'statistics_day': 'Tag',
      'statistics_great_job': 'Großartig!',
      'statistics_streak_message': 'Tage hintereinander! Weiter so! 💪',
      'statistics_first_step': 'Mache den ersten Schritt, der Rest wird folgen! 🚀',
      'statistics_progress': 'Gesamtfortschritt',
      'statistics_cycle': 'Zyklus • Tag',
      
      // All Steps
      'all_steps_title': 'Alle Schritte',
      'all_steps_no_dream': 'Noch kein Traum festgelegt',
      'all_steps_no_completed': 'Noch keine abgeschlossenen Aufgaben',
      'all_steps_no_completed_subtitle': 'Abgeschlossene Aufgaben werden hier angezeigt',
      'all_steps_day': 'Tag',
      
      // Task Detail
      'task_detail_title': 'Heutige Aufgabe',
      'task_detail_today_task': 'Heutige Aufgabe',
      'task_detail_detail': 'Detail',
      'task_detail_motivational': 'Kleine Schritte führen zu großen Träumen. Wenn du die heutige Aufgabe abschließt, bist du einen Schritt näher! 💪',
      
      // About
      'about_title': 'Über',
      'about_version': 'Version',
      'about_build_number': 'Build-Nummer',
      'about_package_name': 'Paketname',
      'about_description_title': 'Über',
      'about_description': 'DreamSteps ist eine App, die entwickelt wurde, um deine Träume in die Realität umzusetzen. Erreiche deine großen Ziele, indem du jeden Tag kleine Schritte machst.',
      
      // Onboarding
      'onboarding_skip': 'Überspringen',
      'onboarding_continue': 'Weiter',
      'onboarding_start': 'Loslegen',
      'onboarding_page1_title': 'Schritte zu deinen Träumen',
      'onboarding_page1_description': 'Jede große Reise beginnt mit kleinen Schritten.',
      'onboarding_page2_title': 'Ein Schritt jeden Tag',
      'onboarding_page2_description': 'Nur ein kleiner Schritt pro Tag, große Veränderung in 30 Tagen.',
      'onboarding_page3_title': 'Bereit für deine Reise?',
      'onboarding_page3_description': 'Schreibe deinen Traum, setze deine Schritte und starte!',
      
      // Reset Dream Dialog
      'reset_dream_title': 'Traum ändern',
      'reset_dream_message': 'Bist du sicher, dass du deinen aktuellen Traum ändern möchtest?',
      'reset_dream_warning': 'Diese Aktion wird löschen:',
      'reset_dream_item1': '• Aktueller Traum und Kategorie',
      'reset_dream_item2': '• Alle Fortschritte und abgeschlossenen Aufgaben',
      'reset_dream_item3': '• Startdatum und Statistiken',
      'reset_dream_footer': 'Du wirst mit einem neuen Traum von vorne beginnen.',
      'reset_dream_cancel': 'Abbrechen',
      'reset_dream_confirm': 'Ja, ändern',
      
      // Completion Modal
      'completion_modal_continue': 'Weiter',
      'completion_modal_congrats': 'Glückwunsch! 🎉',
      'completion_modal_cycle_completed': 'Du hast den 30-Tage-Zyklus abgeschlossen!',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }

  // Getters for easy access
  String get dreamInputTitle => translate('dream_input_title');
  String get dreamInputSubtitle => translate('dream_input_subtitle');
  String get dreamInputHint => translate('dream_input_hint');
  String get dreamInputButton => translate('dream_input_button');
  String get dreamInputError => translate('dream_input_error');
  String dreamInputErrorGeneral(String error) => translate('dream_input_error_general') + error;
  String get dreamInputLoading => translate('dream_input_loading');
  
  String get languageSelectionTitle => translate('language_selection_title');
  String get languageSelectionSubtitle => translate('language_selection_subtitle');
  String get languageTurkish => translate('language_turkish');
  String get languageEnglish => translate('language_english');
  String get languageGerman => translate('language_german');
  
  String get dashboardChangeDream => translate('dashboard_change_dream');
  String get dashboardTodayTask => translate('dashboard_today_task');
  String get dashboardMarkCompleted => translate('dashboard_mark_completed');
  String get dashboardTaskCompleted => translate('dashboard_task_completed');
  String get dashboardTaskAlreadyCompleted => translate('dashboard_task_already_completed');
  String get dashboardCycleDay => translate('dashboard_cycle_day');
  String get dashboardStatistics => translate('dashboard_statistics');
  String get dashboardAllSteps => translate('dashboard_all_steps');
  
  String get statisticsTitle => translate('statistics_title');
  String get statisticsAbout => translate('statistics_about');
  String get statisticsNoDream => translate('statistics_no_dream');
  String get statisticsStreak => translate('statistics_streak');
  String get statisticsTotalCompleted => translate('statistics_total_completed');
  String get statisticsThisWeek => translate('statistics_this_week');
  String get statisticsThisMonth => translate('statistics_this_month');
  String get statisticsTotalTime => translate('statistics_total_time');
  String get statisticsDaysActive => translate('statistics_days_active');
  String get statisticsDay => translate('statistics_day');
  String get statisticsGreatJob => translate('statistics_great_job');
  String statisticsStreakMessage(int days) => '$days ' + translate('statistics_streak_message');
  String get statisticsFirstStep => translate('statistics_first_step');
  String get statisticsProgress => translate('statistics_progress');
  String get statisticsCycle => translate('statistics_cycle');
  
  String get allStepsTitle => translate('all_steps_title');
  String get allStepsNoDream => translate('all_steps_no_dream');
  String get allStepsNoCompleted => translate('all_steps_no_completed');
  String get allStepsNoCompletedSubtitle => translate('all_steps_no_completed_subtitle');
  String get allStepsDay => translate('all_steps_day');
  
  String get taskDetailTitle => translate('task_detail_title');
  String get taskDetailTodayTask => translate('task_detail_today_task');
  String get taskDetailDetail => translate('task_detail_detail');
  String get taskDetailMotivational => translate('task_detail_motivational');
  
  String get aboutTitle => translate('about_title');
  String get aboutVersion => translate('about_version');
  String get aboutBuildNumber => translate('about_build_number');
  String get aboutPackageName => translate('about_package_name');
  String get aboutDescriptionTitle => translate('about_description_title');
  String get aboutDescription => translate('about_description');
  
  String get onboardingSkip => translate('onboarding_skip');
  String get onboardingContinue => translate('onboarding_continue');
  String get onboardingStart => translate('onboarding_start');
  String get onboardingPage1Title => translate('onboarding_page1_title');
  String get onboardingPage1Description => translate('onboarding_page1_description');
  String get onboardingPage2Title => translate('onboarding_page2_title');
  String get onboardingPage2Description => translate('onboarding_page2_description');
  String get onboardingPage3Title => translate('onboarding_page3_title');
  String get onboardingPage3Description => translate('onboarding_page3_description');
  
  String get resetDreamTitle => translate('reset_dream_title');
  String get resetDreamMessage => translate('reset_dream_message');
  String get resetDreamWarning => translate('reset_dream_warning');
  String get resetDreamItem1 => translate('reset_dream_item1');
  String get resetDreamItem2 => translate('reset_dream_item2');
  String get resetDreamItem3 => translate('reset_dream_item3');
  String get resetDreamFooter => translate('reset_dream_footer');
  String get resetDreamCancel => translate('reset_dream_cancel');
  String get resetDreamConfirm => translate('reset_dream_confirm');
  
  String get completionModalContinue => translate('completion_modal_continue');
  String get completionModalCongrats => translate('completion_modal_congrats');
  String completionModalCycleCompleted(int cycle) => '$cycle. ' + translate('completion_modal_cycle_completed');
  
  String get splashAppName => translate('splash_app_name');
  String get splashLoadingTimeout => translate('splash_loading_timeout');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['tr', 'en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}


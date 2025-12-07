import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class AdService {
  static bool _isInitialized = false;

  /// AdMob'u başlat
  static Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('AdService: Already initialized');
      return;
    }

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdService: AdMob initialized successfully');
    } catch (e) {
      debugPrint('AdService: Error initializing AdMob: $e');
      _isInitialized = false;
    }
  }

  /// Test Ad Unit ID'leri
  /// Production'da gerçek Ad Unit ID'lerini kullanın
  static String get bannerAdUnitId {
    if (kDebugMode) {
      // Test ad unit ID (Google'ın sağladığı test ID)
      return 'ca-app-pub-3940256099942544/6300978111'; // Android test
      // iOS için: 'ca-app-pub-3940256099942544/2934735716'
    } else {
      // Production ad unit ID - Gerçek Ad Unit ID'nizi buraya ekleyin
      // TODO: Production Ad Unit ID'yi buraya ekleyin
      return 'ca-app-pub-3940256099942544/6300978111'; // Şimdilik test ID
    }
  }

  /// iOS için banner ad unit ID
  static String get bannerAdUnitIdIOS {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test
    } else {
      // Production ad unit ID - Gerçek Ad Unit ID'nizi buraya ekleyin
      return 'ca-app-pub-3940256099942544/2934735716'; // Şimdilik test ID
    }
  }
}




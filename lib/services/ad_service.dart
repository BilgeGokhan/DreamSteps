import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class AdService {
  static bool _isInitialized = false;

  /// AdMob'u başlat
  /// iOS için ATT (App Tracking Transparency) izni ister
  static Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint('AdService: Already initialized');
      return;
    }

    try {
      // iOS için ATT izni iste (iOS 14.5+)
      if (Platform.isIOS) {
        try {
          final status = await AppTrackingTransparency.trackingAuthorizationStatus;
          debugPrint('AdService: Current ATT status: $status');
          
          // Eğer henüz izin istenmemişse, izin iste
          if (status == TrackingStatus.notDetermined) {
            final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
            debugPrint('AdService: ATT authorization requested. New status: $newStatus');
          }
        } catch (e) {
          debugPrint('AdService: Error requesting ATT permission: $e');
          // ATT hatası olsa bile AdMob'u başlatmaya devam et
        }
      }

      await MobileAds.instance.initialize();
      _isInitialized = true;
      debugPrint('AdService: AdMob initialized successfully');
    } catch (e) {
      debugPrint('AdService: Error initializing AdMob: $e');
      _isInitialized = false;
    }
  }

  /// Ad Unit ID'leri
  /// Debug modda test ID'leri, production'da gerçek ID'ler kullanılır
  static String get bannerAdUnitId {
    if (kDebugMode) {
      // Test ad unit ID (Google'ın sağladığı test ID)
      return 'ca-app-pub-3940256099942544/6300978111'; // Android test
    } else {
      // Production ad unit ID
      return 'ca-app-pub-9905832999228548/9051085393';
    }
  }

  /// iOS için banner ad unit ID
  static String get bannerAdUnitIdIOS {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS test
    } else {
      // Production ad unit ID - iOS için Android ile aynı ID kullanılıyor
      // Not: iOS için AdMob'da ayrı bir Ad Unit oluşturmanız önerilir
      return 'ca-app-pub-9905832999228548/9051085393'; // iOS production (Android ile aynı)
    }
  }
}

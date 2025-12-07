# Google AdMob Kurulum Rehberi

## ✅ Yapılan Entegrasyon

Google Mobile Ads SDK başarıyla entegre edildi. Şu anda **test reklamları** kullanılıyor.

## 📋 Production'a Geçiş

### 1. AdMob Hesabı Oluşturun
1. [Google AdMob](https://admob.google.com/) adresine gidin
2. Hesap oluşturun ve uygulamanızı ekleyin
3. Banner reklam birimi oluşturun

### 2. Gerçek Ad Unit ID'leri Ekleyin

**Android için:**
`lib/services/ad_service.dart` dosyasında:
```dart
static String get bannerAdUnitId {
  if (kDebugMode) {
    return 'ca-app-pub-3940256099942544/6300978111'; // Test ID
  } else {
    return 'ca-app-pub-XXXXXXXXXX/XXXXXXXXXX'; // Gerçek Ad Unit ID
  }
}
```

**iOS için:**
```dart
static String get bannerAdUnitIdIOS {
  if (kDebugMode) {
    return 'ca-app-pub-3940256099942544/2934735716'; // Test ID
  } else {
    return 'ca-app-pub-XXXXXXXXXX/XXXXXXXXXX'; // Gerçek Ad Unit ID
  }
}
```

### 3. AdMob App ID'lerini Güncelleyin

**Android:**
`android/app/src/main/AndroidManifest.xml` dosyasında:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXX~XXXXXXXXXX"/>
```

**iOS:**
`ios/Runner/Info.plist` dosyasında:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXX~XXXXXXXXXX</string>
```

## 📍 Reklam Konumları

- **Dashboard Screen:** Alt kısımda banner reklam gösteriliyor

## 🧪 Test Reklamları

Şu anda Google'ın sağladığı test reklamları kullanılıyor:
- Android Test ID: `ca-app-pub-3940256099942544/6300978111`
- iOS Test ID: `ca-app-pub-3940256099942544/2934735716`

## ⚠️ Önemli Notlar

1. **Test Reklamları:** Test modunda sadece Google'ın test reklamları gösterilir
2. **Production:** Production'da gerçek Ad Unit ID'lerini kullanmalısınız
3. **Politikalar:** Google AdMob politikalarına uygun olduğunuzdan emin olun
4. **GDPR:** Avrupa kullanıcıları için GDPR uyumluluğu gerekebilir

## 🔧 Sorun Giderme

- Reklamlar görünmüyorsa: AdMob hesabınızın aktif olduğundan emin olun
- Test reklamları çalışıyor ama production'da çalışmıyorsa: Ad Unit ID'lerini kontrol edin
- Hata mesajları için: `lib/services/ad_service.dart` ve `lib/widgets/ad_banner.dart` dosyalarındaki debug print'leri kontrol edin




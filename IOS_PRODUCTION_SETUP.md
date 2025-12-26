# iOS Production Build Hazırlık Rehberi

## ✅ Yapılan Yapılandırmalar

### 1. Bundle Identifier
- ✅ Bundle ID güncellendi: `com.yaylagokhan.dreamsteps`
- ✅ Android ile aynı bundle ID kullanılıyor

### 2. AdMob Yapılandırması
- ✅ **App ID:** `ca-app-pub-9905832999228548~1605400712` (Info.plist'te)
- ✅ **Ad Unit ID (iOS):** `ca-app-pub-9905832999228548/9051085393` (AdService'de)
- ⚠️ **Not:** iOS için AdMob'da ayrı bir Ad Unit oluşturmanız önerilir

### 3. Privacy Permissions
- ✅ `NSUserTrackingUsageDescription` eklendi (reklam kimliği için)
- ✅ `SKAdNetworkItems` eklendi (AdMob için)

### 4. Versiyon
- ✅ Versiyon: `1.0.4+4` (pubspec.yaml'dan otomatik alınır)

## 📋 iOS Production Build İçin Gerekenler

### 1. Apple Developer Hesabı
- Apple Developer Program üyeliği gereklidir ($99/yıl)
- https://developer.apple.com/programs/

### 2. Xcode Yapılandırması
1. Xcode'da projeyi açın:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Signing & Capabilities** ayarları:
   - Team seçin (Apple Developer hesabınız)
   - Bundle Identifier: `com.yaylagokhan.dreamsteps`
   - Automatically manage signing: ✅ Aktif

3. **Build Settings:**
   - iOS Deployment Target: 12.0 veya üzeri
   - Swift Language Version: Swift 5

### 3. App Store Connect'te Uygulama Oluşturma
1. https://appstoreconnect.apple.com adresine gidin
2. "My Apps" > "+" > "New App"
3. Bilgileri doldurun:
   - Platform: iOS
   - Name: DreamSteps
   - Primary Language: Turkish
   - Bundle ID: `com.yaylagokhan.dreamsteps`
   - SKU: `dreamsteps-ios`

### 4. iOS Production Build Oluşturma

#### Yöntem 1: Flutter CLI ile (Önerilen)
```bash
# Release build
flutter build ios --release

# Archive oluşturmak için Xcode kullanın
open ios/Runner.xcworkspace
# Xcode'da: Product > Archive
```

#### Yöntem 2: Xcode ile
1. Xcode'da projeyi açın: `open ios/Runner.xcworkspace`
2. Product > Scheme > Runner seçin
3. Product > Destination > Any iOS Device seçin
4. Product > Archive
5. Archive tamamlandıktan sonra "Distribute App" seçin
6. App Store Connect'e yükleyin

### 5. TestFlight ile Test
1. Archive oluşturduktan sonra "Distribute App" seçin
2. "App Store Connect" seçin
3. Upload tamamlandıktan sonra App Store Connect'te:
   - TestFlight sekmesine gidin
   - Test kullanıcıları ekleyin
   - Beta test için onaylayın

### 6. App Store'a Yayınlama
1. App Store Connect'te uygulama bilgilerini doldurun
2. Screenshot'lar ekleyin (çeşitli cihaz boyutları için)
3. Privacy Policy URL ekleyin
4. App Store Review bilgilerini doldurun
5. "Submit for Review" butonuna tıklayın

## ⚠️ Önemli Notlar

### AdMob iOS Ad Unit ID
Şu anda iOS için Android ile aynı Ad Unit ID kullanılıyor. **Önerilen:** AdMob Console'da iOS için ayrı bir Ad Unit oluşturun ve `lib/services/ad_service.dart` dosyasındaki `bannerAdUnitIdIOS` getter'ını güncelleyin.

### Privacy Policy
App Store, privacy policy URL'i gerektirir. GitHub Pages veya başka bir hosting kullanabilirsiniz.

### Minimum iOS Version
- Şu anda minimum iOS 12.0 destekleniyor
- Daha yeni özellikler için iOS 13.0+ önerilir

### App Icons
- App icon'lar `ios/Runner/Assets.xcassets/AppIcon.appiconset/` klasöründe
- Tüm gerekli boyutlar mevcut

### Launch Screen
- Launch screen `ios/Runner/Base.lproj/LaunchScreen.storyboard` dosyasında
- Özelleştirilebilir

## 🚀 Hızlı Başlangıç

```bash
# 1. Dependencies yükle
flutter pub get

# 2. iOS build
flutter build ios --release

# 3. Xcode'da aç ve archive oluştur
open ios/Runner.xcworkspace
```

## 📝 Checklist

- [ ] Apple Developer hesabı aktif
- [ ] Xcode'da signing yapılandırıldı
- [ ] App Store Connect'te uygulama oluşturuldu
- [ ] Bundle ID doğru: `com.yaylagokhan.dreamsteps`
- [ ] AdMob App ID doğru: `ca-app-pub-9905832999228548~1605400712`
- [ ] iOS Ad Unit ID eklendi (veya Android ile aynı kullanılıyor)
- [ ] Privacy Policy URL hazır
- [ ] Screenshot'lar hazır
- [ ] App Store açıklaması hazır
- [ ] TestFlight test edildi
- [ ] Production build oluşturuldu ve yüklendi

## 🔗 Faydalı Linkler

- [Apple Developer](https://developer.apple.com/)
- [App Store Connect](https://appstoreconnect.apple.com/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [AdMob iOS Setup](https://developers.google.com/admob/ios/quick-start)




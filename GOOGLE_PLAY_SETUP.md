# Google Play Store Yükleme Rehberi

Bu rehber, Dream Steps uygulamasını Google Play Store'a yüklemek için gerekli adımları içerir.

## Ön Hazırlık

### 1. Google Play Console Hesabı
- Google Play Console hesabı oluşturun: https://play.google.com/console
- Geliştirici kayıt ücreti: $25 (tek seferlik)

### 2. Keystore Oluşturma

Release build için bir keystore oluşturmanız gerekiyor. Bu keystore'u GÜVENLİ bir yerde saklayın, kaybederseniz uygulama güncellemeleri yapamazsınız!

#### Windows'ta Keystore Oluşturma:

```bash
# Android klasörüne gidin
cd android

# keystore klasörü oluşturun
mkdir keystore

# Keystore oluşturun (25 yıl geçerli)
keytool -genkey -v -keystore keystore/dreamsteps-release-key.jks -keyalg RSA -keysize 2048 -validity 9125 -alias dreamsteps-key
```

**Önemli Bilgiler:**
- Keystore password: Güçlü bir şifre seçin ve kaydedin
- Key password: Genelde keystore password ile aynı olabilir
- Key alias: `dreamsteps-key` (veya istediğiniz bir isim)
- Validity: 9125 gün (25 yıl)

#### key.properties Dosyası Oluşturma:

1. `android/key.properties.example` dosyasını kopyalayın
2. `android/key.properties` olarak kaydedin
3. Aşağıdaki bilgileri doldurun:

```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=dreamsteps-key
storeFile=../keystore/dreamsteps-release-key.jks
```

**ÖNEMLİ:** `key.properties` dosyasını `.gitignore`'a ekleyin (zaten ekli olmalı)

### 3. AdMob App ID Güncelleme

1. AdMob Console'a gidin: https://apps.admob.com
2. Uygulamanızı oluşturun ve App ID'nizi alın
3. `android/app/src/main/AndroidManifest.xml` dosyasında test App ID'yi gerçek App ID ile değiştirin:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXX~XXXXXXXXXX"/>
```

## Build ve Test

### Release APK Oluşturma:

```bash
# Release APK oluştur
flutter build apk --release

# APK dosyası şurada olacak:
# build/app/outputs/flutter-apk/app-release.apk
```

### App Bundle (AAB) Oluşturma (Önerilen):

Google Play Store, AAB formatını tercih eder:

```bash
# App Bundle oluştur
flutter build appbundle --release

# AAB dosyası şurada olacak:
# build/app/outputs/bundle/release/app-release.aab
```

### Test:

1. Release APK'yı bir Android cihaza yükleyin
2. Tüm özellikleri test edin
3. AdMob reklamlarının çalıştığını kontrol edin

## Google Play Console'a Yükleme

### 1. Yeni Uygulama Oluşturma

1. Google Play Console'a giriş yapın
2. "Uygulama oluştur" butonuna tıklayın
3. Uygulama adı: **Dream Steps**
4. Varsayılan dil: **Türkçe**
5. Uygulama türü: **Uygulama**
6. Ücretsiz/Ücretli: **Ücretsiz**

### 2. Uygulama Bilgileri

#### Store Listing:

- **Uygulama adı:** Dream Steps
- **Kısa açıklama:** (80 karakter max)
  - TR: "Hayallerinizi gerçekleştirmek için adım adım ilerleyin"
  - EN: "Take steps to achieve your dreams"
  - DE: "Gehen Sie Schritt für Schritt, um Ihre Träume zu verwirklichen"

- **Tam açıklama:** (4000 karakter max)
  ```
  Dream Steps, hayallerinizi gerçekleştirmek için tasarlanmış kapsamlı bir hedef takip uygulamasıdır.
  
  Özellikler:
  - Kişisel hayallerinizi belirleyin ve takip edin
  - Günlük görevlerle ilerlemenizi görselleştirin
  - İstatistiklerle motivasyonunuzu artırın
  - Tamamen offline çalışır
  - Türkçe, İngilizce ve Almanca dil desteği
  
  [Daha fazla detay ekleyin...]
  ```

- **Uygulama ikonu:** 512x512 PNG (yüksek kalite)
- **Özellik grafiği:** 1024x500 PNG
- **Ekran görüntüleri:** 
  - En az 2, en fazla 8 adet
  - Telefon: 16:9 veya 9:16, min 320px, max 3840px
  - Tablet: 16:9 veya 9:16, min 320px, max 3840px

#### Kategori ve İçerik Derecelendirmesi:

- **Kategori:** Yaşam Tarzı / Productivity
- **İçerik derecelendirmesi:** PEGI 3 / Everyone

### 3. İçerik Derecelendirmesi

Google Play Console'da içerik derecelendirmesi anketini doldurun:
- Reklam içeriyor mu? **Evet** (AdMob kullanıyoruz)
- Kullanıcı verileri topluyor mu? **Hayır** (tamamen offline)
- vb.

### 4. Gizlilik Politikası

Google Play Store, bir Gizlilik Politikası URL'si gerektirir. Birkaç seçenek:

**Seçenek 1: Ücretsiz Gizlilik Politikası Oluşturucu**
- https://www.freeprivacypolicy.com/
- https://www.privacypolicygenerator.info/

**Seçenek 2: GitHub Pages**
- GitHub'da bir repo oluşturun
- `privacy-policy.html` dosyası ekleyin
- GitHub Pages'i etkinleştirin
- URL: `https://yourusername.github.io/privacy-policy`

**Gizlilik Politikası İçeriği Örneği:**

```
Gizlilik Politikası

Dream Steps uygulaması ("Biz", "Bizim") gizliliğinize saygı duyar.

Veri Toplama:
- Uygulama tamamen offline çalışır
- Kişisel verileriniz cihazınızda saklanır
- Hiçbir veri sunuculara gönderilmez

Reklamlar:
- Uygulama Google AdMob reklamları gösterir
- AdMob, reklam gösterimi için cihaz bilgileri toplayabilir
- AdMob gizlilik politikası: https://policies.google.com/privacy

İletişim:
[E-posta adresiniz]
```

### 5. APK/AAB Yükleme

1. **Production** sekmesine gidin
2. **Yeni sürüm oluştur** butonuna tıklayın
3. AAB dosyasını yükleyin (`app-release.aab`)
4. Sürüm notları ekleyin:
   ```
   İlk sürüm
   - Hayal takibi özelliği
   - Günlük görevler
   - İstatistikler
   - Çoklu dil desteği (TR, EN, DE)
   ```

### 6. İnceleme ve Yayınlama

1. Tüm bilgileri kontrol edin
2. **Gönder** butonuna tıklayın
3. İnceleme süreci genellikle 1-3 gün sürer
4. İnceleme sonrası uygulama yayınlanır

## Güncelleme Yapma

Uygulama güncellemesi yapmak için:

1. `pubspec.yaml` dosyasında versiyonu artırın:
   ```yaml
   version: 1.0.1+2  # +2 versionCode'u artırır
   ```

2. Yeni AAB oluşturun:
   ```bash
   flutter build appbundle --release
   ```

3. Google Play Console'da yeni sürüm oluşturun ve AAB'yi yükleyin

## Önemli Notlar

### Keystore Güvenliği:
- Keystore dosyasını ve şifrelerini GÜVENLİ bir yerde saklayın
- Keystore'u kaybederseniz uygulama güncellemeleri yapamazsınız
- Keystore'u yedekleyin (cloud storage, USB, vb.)

### AdMob:
- Test reklamları ile test edin
- Gerçek App ID'yi production'da kullanın
- AdMob politikalarına uyun

### Uygulama İmzası:
- Release build'lerde mutlaka imzalı keystore kullanın
- Debug keystore ile yayınlamayın

### Versiyon Yönetimi:
- Her yayın için `versionCode`'u artırın
- `versionName` kullanıcıya gösterilen versiyon numarasıdır

## Sorun Giderme

### Build Hataları:

```bash
# Flutter temizleme
flutter clean
flutter pub get

# Gradle temizleme
cd android
./gradlew clean
cd ..
```

### Keystore Hatası:

Eğer keystore bulunamazsa, `key.properties` dosyasını kontrol edin ve yolların doğru olduğundan emin olun.

### Signing Config Hatası:

`build.gradle.kts` dosyasında signing config'in doğru yapılandırıldığından emin olun.

## Yardımcı Kaynaklar

- [Flutter Release Documentation](https://docs.flutter.dev/deployment/android)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [AdMob Documentation](https://developers.google.com/admob/android/quick-start)


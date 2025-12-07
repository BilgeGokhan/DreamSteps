# Flutter Kurulum Rehberi (Windows)

## Hızlı Kurulum

### 1. Flutter SDK İndirme

1. **Flutter'ı İndirin:**
   - https://docs.flutter.dev/get-started/install/windows adresine gidin
   - Veya direkt: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.0-stable.zip
   - ZIP dosyasını indirin (yaklaşık 1.5 GB)

2. **ZIP'i Açın:**
   - İndirdiğiniz ZIP dosyasını `C:\src\flutter` gibi bir klasöre çıkarın
   - **ÖNEMLİ:** Klasör yolunda boşluk veya özel karakter olmamalı

### 2. PATH'e Ekleme

1. **Sistem Değişkenlerini Açın:**
   - Windows tuşu + R
   - `sysdm.cpl` yazın ve Enter'a basın
   - "Gelişmiş" sekmesine gidin
   - "Ortam Değişkenleri" butonuna tıklayın

2. **PATH'e Ekle:**
   - "Sistem değişkenleri" altında "Path" seçin
   - "Düzenle" butonuna tıklayın
   - "Yeni" butonuna tıklayın
   - Flutter klasörünün yolunu ekleyin: `C:\src\flutter\bin`
   - Tüm pencereleri "Tamam" ile kapatın

3. **Yeni Terminal Açın:**
   - Mevcut terminali kapatıp yeni bir terminal açın
   - `flutter --version` komutunu çalıştırın
   - Flutter versiyonu görünmeli

### 3. Flutter Doctor Kontrolü

```bash
flutter doctor
```

Bu komut eksik bileşenleri gösterecek. Genellikle şunlar gerekir:
- Android Studio (Android geliştirme için)
- VS Code veya Android Studio (IDE)
- Chrome (Web geliştirme için)

### 4. Android Studio Kurulumu (Android için)

1. https://developer.android.com/studio adresinden Android Studio'yu indirin
2. Kurulum sırasında "Android SDK" seçeneğini işaretleyin
3. Android Studio'yu açın ve SDK'yı kurun

### 5. Projeyi Çalıştırma

```bash
cd c:\CursorRepos\dreamsteps
flutter pub get
flutter run
```

## Alternatif: Flutter'ı PATH'e Eklemek (PowerShell)

PowerShell'i **Yönetici olarak** açın ve şunu çalıştırın:

```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\src\flutter\bin", [EnvironmentVariableTarget]::Machine)
```

## Hızlı Test (Flutter Olmadan)

Flutter kurmadan önce kodun doğruluğunu kontrol etmek için:

1. **Dart SDK** (Flutter'ın bir parçası) yeterli değil, tam Flutter SDK gerekli
2. **VS Code** ile Flutter extension'ı kurarak syntax kontrolü yapabilirsiniz
3. **GitHub Codespaces** veya **Gitpod** gibi online IDE'ler kullanabilirsiniz

## Sorun Giderme

### "flutter komutu bulunamadı"
- PATH'e eklediğinizden emin olun
- Terminali yeniden başlatın
- Flutter klasörünün doğru yerde olduğunu kontrol edin

### "Android SDK bulunamadı"
- Android Studio'yu kurun
- `flutter doctor --android-licenses` komutunu çalıştırın

## Daha Kolay Yol: Flutter SDK Manager

1. **Chocolatey** ile (eğer kuruluysa):
   ```powershell
   choco install flutter
   ```

2. **Scoop** ile (eğer kuruluysa):
   ```powershell
   scoop install flutter
   ```

## İnternet Bağlantısı Gerekli

Flutter kurulumu ve ilk çalıştırmada internet bağlantısı gereklidir çünkü:
- Bağımlılıklar indirilir
- Dart SDK indirilir
- Gradle ve diğer araçlar indirilir









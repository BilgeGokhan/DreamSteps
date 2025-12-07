# DreamSteps

A fully offline Flutter app for tracking dreams and goals.

## Flutter Kurulumu

Flutter kurulu değilse, önce Flutter'ı kurmanız gerekiyor:

**Windows için:**
1. https://docs.flutter.dev/get-started/install/windows adresinden Flutter SDK'yı indirin
2. ZIP dosyasını `C:\src\flutter` gibi bir klasöre çıkarın
3. PATH'e `C:\src\flutter\bin` ekleyin
4. Detaylı kurulum için `FLUTTER_KURULUM.md` dosyasına bakın

**Hızlı Kurulum (Chocolatey ile):**
```powershell
choco install flutter
```

## Project Structure

- `lib/main.dart` - App entry point
- `lib/models/` - Data models
- `lib/services/` - JSON loaders, local storage helpers
- `lib/state/` - App state (e.g. DreamState, providers)
- `lib/screens/` - Screens (splash, onboarding, input, dashboard, task list, completion modal)
- `lib/widgets/` - Reusable UI components
- `assets/json/` - JSON data files
- `assets/animations/` - Lottie animations
- `assets/images/` - Logos or icons

## Getting Started

1. **Flutter'ı kurun** (yukarıdaki adımlara bakın)

2. **Bağımlılıkları yükleyin:**
   ```bash
   flutter pub get
   ```

3. **Uygulamayı çalıştırın:**
   ```bash
   flutter run
   ```

4. **Cihaz seçimi:**
   - Android emülatör veya fiziksel cihaz
   - iOS simülatör (Mac'te)
   - Web tarayıcı: `flutter run -d chrome`
   - Windows desktop: `flutter run -d windows`

## Test Etme

```bash
# Tüm testleri çalıştır
flutter test

# Belirli bir cihazda çalıştır
flutter run -d <device-id>

# Mevcut cihazları listele
flutter devices
```


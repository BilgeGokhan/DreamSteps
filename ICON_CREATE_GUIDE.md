# Uygulama İkonu Oluşturma Rehberi

Splash screen'deki yıldızlar ikonunu (`Icons.auto_awesome`) uygulama ikonu olarak kullanmak için:

## Yöntem 1: Online Tool Kullanarak (Önerilen)

1. **Canva veya Figma'da:**
   - 1024x1024 px yeni bir tasarım oluşturun
   - Arka plan rengi: #4C6EF5 (mavi)
   - Merkeze büyük bir yıldız (5 köşeli) ekleyin (beyaz renk)
   - Etrafına küçük yıldızlar ekleyin (dekoratif)
   - PNG olarak export edin
   - Dosyayı `assets/icons/app_icon.png` olarak kaydedin

2. **İkonları oluşturun:**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

## Yöntem 2: Flutter Icon Generator

1. **https://www.fluttericon.com/** adresine gidin
2. Material Icons'dan `auto_awesome` seçin
3. Renk: Beyaz, Arka plan: #4C6EF5
4. 1024x1024 boyutunda export edin
5. `assets/icons/app_icon.png` olarak kaydedin
6. Komutu çalıştırın: `flutter pub run flutter_launcher_icons:main`

## Yöntem 3: Basit Tasarım Özellikleri

- **Boyut:** 1024x1024 px
- **Arka plan:** #4C6EF5 (mavi, yuvarlatılmış köşeler)
- **Ana ikon:** Beyaz yıldız (merkez, büyük)
- **Dekoratif:** Küçük yıldızlar (etrafında)
- **Stil:** Minimal, modern, hatırlanabilir

## Hızlı Başlangıç

Eğer hızlı bir şekilde test etmek istiyorsanız:

1. Herhangi bir 1024x1024 px PNG dosyası oluşturun (geçici)
2. `assets/icons/app_icon.png` olarak kaydedin
3. `flutter pub run flutter_launcher_icons:main` komutunu çalıştırın
4. Daha sonra profesyonel bir ikon tasarımı yapabilirsiniz




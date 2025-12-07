# Uygulama İkonu Kurulumu

## Adımlar

1. **İkon Dosyası Oluşturun:**
   - 1024x1024 piksel boyutunda bir PNG dosyası oluşturun
   - Dosyayı `assets/icons/app_icon.png` olarak kaydedin
   - İkon tasarımı: DreamSteps uygulaması için uygun bir ikon (örn: yıldız, adım, hedef simgesi)

2. **İkonları Oluşturun:**
   Terminal'de şu komutu çalıştırın:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

3. **Sonuç:**
   - Android ve iOS için tüm gerekli ikon boyutları otomatik oluşturulacak
   - Adaptive icon (Android) için arka plan rengi: #4C6EF5 (mavi)

## İkon Tasarım Önerileri

- **Renk:** Ana renk #4C6EF5 (mavi) ile uyumlu
- **Tasarım:** Basit, modern, hatırlanabilir
- **İçerik:** Yıldız, adım, hedef veya benzeri motivasyonel simgeler
- **Stil:** Flat design, minimal

## Not

Eğer ikon dosyası yoksa, önce bir ikon tasarlayıp `assets/icons/app_icon.png` olarak kaydedin.




# Gizlilik Politikası URL Kurulumu

Dream Steps uygulaması için gizlilik politikası URL'si oluşturmanız gerekiyor. İşte birkaç seçenek:

## Seçenek 1: GitHub Pages (Önerilen - Ücretsiz)

### Adımlar:

1. **GitHub'da yeni bir repository oluşturun:**
   - Repository adı: `dreamsteps-privacy-policy` (veya istediğiniz bir isim)
   - Public olarak oluşturun
   - README eklemeyin

2. **Repository'yi klonlayın:**
   ```bash
   git clone https://github.com/yourusername/dreamsteps-privacy-policy.git
   cd dreamsteps-privacy-policy
   ```

3. **privacy-policy.html dosyasını kopyalayın:**
   - Projenizdeki `privacy-policy.html` dosyasını bu klasöre kopyalayın

4. **GitHub'a yükleyin:**
   ```bash
   git add privacy-policy.html
   git commit -m "Add privacy policy"
   git push origin main
   ```

5. **GitHub Pages'i etkinleştirin:**
   - Repository sayfasında **Settings** sekmesine gidin
   - Sol menüden **Pages** seçeneğini bulun
   - **Source** altında **Deploy from a branch** seçin
   - Branch: `main`, Folder: `/ (root)` seçin
   - **Save** butonuna tıklayın

6. **URL'nizi alın:**
   - URL şu formatta olacak: `https://yourusername.github.io/dreamsteps-privacy-policy/privacy-policy.html`
   - Veya `index.html` olarak yeniden adlandırırsanız: `https://yourusername.github.io/dreamsteps-privacy-policy/`

### Örnek URL:
```
https://yourusername.github.io/dreamsteps-privacy-policy/privacy-policy.html
```

## Seçenek 2: Netlify (Ücretsiz ve Hızlı)

1. **Netlify hesabı oluşturun:** https://www.netlify.com
2. **Drag & Drop:** `privacy-policy.html` dosyasını Netlify'a sürükleyip bırakın
3. **URL alın:** Otomatik olarak bir URL oluşturulur (örn: `https://random-name-123.netlify.app`)

## Seçenek 3: Vercel (Ücretsiz)

1. **Vercel hesabı oluşturun:** https://vercel.com
2. **Yeni proje oluşturun**
3. **privacy-policy.html dosyasını yükleyin**
4. **URL alın**

## Seçenek 4: Kendi Web Siteniz

Eğer zaten bir web siteniz varsa:
- `privacy-policy.html` dosyasını sitenize yükleyin
- URL: `https://yourwebsite.com/privacy-policy.html`

## Gizlilik Politikası İçeriğini Özelleştirme

`privacy-policy.html` dosyasında şu bilgileri güncelleyin:

1. **E-posta adresi:** `[E-posta adresinizi buraya ekleyin]` kısmını değiştirin
2. **Geliştirici adı:** `[Geliştirici adınızı buraya ekleyin]` kısmını değiştirin
3. **Son güncelleme tarihi:** `Son Güncelleme: 2024` kısmını güncelleyin

## Google Play Console'a Ekleme

1. Google Play Console'a giriş yapın
2. Uygulamanızı seçin
3. **Store presence** > **Store listing** sekmesine gidin
4. **Privacy Policy** bölümüne gizlilik politikası URL'nizi ekleyin
5. Kaydedin

## Önemli Notlar

- ✅ URL herkese açık olmalı (public)
- ✅ HTTPS kullanılmalı (GitHub Pages, Netlify, Vercel otomatik sağlar)
- ✅ Sayfa mobil cihazlarda düzgün görünmeli
- ✅ İçerik Türkçe, İngilizce ve Almanca olabilir (veya çok dilli)

## Çok Dilli Gizlilik Politikası

Eğer çok dilli bir gizlilik politikası istiyorsanız:
- Her dil için ayrı dosya oluşturun: `privacy-policy-tr.html`, `privacy-policy-en.html`, `privacy-policy-de.html`
- Veya tek bir sayfada dil seçici ekleyin

## Test Etme

URL'nizi oluşturduktan sonra:
1. Tarayıcıda açın ve görünümü kontrol edin
2. Mobil cihazdan test edin
3. Google Play Console'a ekleyin

---

**Önerilen URL formatı:**
```
https://yourusername.github.io/dreamsteps-privacy-policy/privacy-policy.html
```

Bu URL'yi Google Play Console'da kullanabilirsiniz.


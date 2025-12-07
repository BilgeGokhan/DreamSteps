/// Genişletilmiş kategori anahtar kelimeleri
/// 
/// Her kategori için 20-40 anahtar kelime içerir:
/// - Türkçe basit formlar
/// - Türkçe çekimler
/// - Yazım hatalı versiyonlar
/// - İngilizce karşılıklar
/// - Argo/günlük konuşma formları
class CategoryKeywords {
  /// Kategori ID'lerine göre anahtar kelime listeleri
  static const Map<String, List<String>> keywords = {
    'finance': [
      // Türkçe basit formlar
      'para', 'biriktir', 'tasarruf', 'birikim', 'finans', 'kredi', 'borç',
      'yatırım', 'hisse', 'borsa', 'altın', 'döviz', 'faiz', 'gelir',
      'gider', 'bütçe', 'ekonomi', 'zengin', 'servet', 'varlık',
      // Türkçe çekimler ve varyasyonlar
      'para biriktirmek', 'para kazanmak', 'para yatırmak', 'para çekmek',
      'tasarruf etmek', 'birikim yapmak', 'yatırım yapmak', 'borç ödemek',
      'kredi çekmek', 'kredi kartı', 'banka hesabı', 'tasarruf hesabı',
      // Yazım hataları ve varyasyonlar
      'parra', 'paraa', 'biriktirmek', 'tasaruf', 'tasaruf', 'finansal',
      'kredii', 'borçç', 'yatırım', 'yatırım', 'hisse senedi',
      // İngilizce karşılıklar
      'money', 'save', 'saving', 'finance', 'financial', 'credit', 'debt',
      'investment', 'stock', 'gold', 'currency', 'interest', 'income',
      'expense', 'budget', 'economy', 'rich', 'wealth', 'asset',
      'bank', 'account', 'deposit', 'withdraw', 'loan', 'mortgage',
      // Argo/günlük konuşma
      'nakit', 'likit', 'nakit para', 'para kazanma', 'para kazanmak',
      'zengin olmak', 'milyoner', 'milyarder', 'para biriktirme',
    ],

    'car_home': [
      // Türkçe basit formlar
      'ev', 'araba', 'otomobil', 'porsche', 'bmw', 'audi', 'mercedes',
      'tapu', 'kira', 'konut', 'daire', 'villa', 'müstakil', 'apartman',
      'arazi', 'arsa', 'emlak', 'gayrimenkul', 'satın almak', 'almak',
      // Türkçe çekimler ve varyasyonlar
      'ev almak', 'ev satın almak', 'araba almak', 'otomobil almak',
      'ev sahibi olmak', 'araba sahibi olmak', 'tapu almak', 'kira ödemek',
      'ev kiralama', 'araba kiralama', 'konut almak', 'daire almak',
      'villa almak', 'müstakil ev', 'apartman dairesi', 'arazi almak',
      'arsa almak', 'emlak almak', 'gayrimenkul almak',
      // Yazım hataları ve varyasyonlar
      'evv', 'arabaa', 'otomobill', 'porshe', 'bmvv', 'audii', 'mercedess',
      'tappu', 'kirra', 'konutt', 'dairre', 'villaa', 'müstakill',
      'apartmann', 'arazii', 'arsaa', 'emlakk', 'gayrimenkull',
      // İngilizce karşılıklar
      'home', 'house', 'car', 'automobile', 'vehicle', 'property', 'real estate',
      'apartment', 'flat', 'villa', 'land', 'plot', 'buy', 'purchase',
      'rent', 'lease', 'mortgage', 'deed', 'title', 'ownership',
      // Argo/günlük konuşma
      'ev sahibi', 'araba sahibi', 'ev almak istiyorum', 'araba almak istiyorum',
      'kendi evim', 'kendi arabam', 'ev sahibi olmak', 'araba sahibi olmak',
      'yeni ev', 'yeni araba', 'hayalimdeki ev', 'hayalimdeki araba',
    ],

    'fitness': [
      // Türkçe basit formlar
      'kilo', 'fit', 'zayıf', 'fitness', 'spor salonu', 'kas', 'diyet',
      'egzersiz', 'antrenman', 'koşu', 'yürüyüş', 'ağırlık', 'protein',
      'kardiyovasküler', 'vücut', 'form', 'sağlıklı', 'zayıflama', 'kilo verme',
      'kas yapma', 'güç', 'dayanıklılık', 'esneklik', 'kondisyon',
      // Türkçe çekimler ve varyasyonlar
      'kilo vermek', 'kilo almak', 'zayıflamak', 'fit olmak', 'formda olmak',
      'spor yapmak', 'egzersiz yapmak', 'antrenman yapmak', 'koşmak',
      'yürümek', 'ağırlık kaldırmak', 'kas yapmak', 'güçlenmek',
      'dayanıklılık kazanmak', 'esneklik kazanmak', 'kondisyon kazanmak',
      'diyet yapmak', 'protein almak', 'kardiyovasküler egzersiz',
      // Yazım hataları ve varyasyonlar
      'killlo', 'fitt', 'zayıff', 'fitnes', 'spor saloonu', 'kass',
      'diyett', 'egzersizz', 'antrenmann', 'koşuu', 'yürüyüşş',
      'ağırlıkk', 'proteinn', 'kardiyovaskülerr', 'vücutt', 'formm',
      // İngilizce karşılıklar
      'weight', 'fit', 'thin', 'fitness', 'gym', 'muscle', 'diet',
      'exercise', 'workout', 'running', 'walking', 'weightlifting', 'protein',
      'cardio', 'cardiovascular', 'body', 'shape', 'healthy', 'weight loss',
      'muscle building', 'strength', 'endurance', 'flexibility', 'conditioning',
      // Argo/günlük konuşma
      'kilo vermek istiyorum', 'zayıflamak istiyorum', 'fit olmak istiyorum',
      'kas yapmak istiyorum', 'spor yapmak istiyorum', 'diyet yapmak istiyorum',
      'formda olmak', 'sağlıklı olmak', 'güçlü olmak', 'dayanıklı olmak',
    ],

    'health': [
      // Türkçe basit formlar
      'sağlık', 'doktora', 'muayene', 'vitamin', 'iyileş', 'tedavi',
      'hastane', 'ilaç', 'check-up', 'kontrol', 'sağlıklı', 'hastalık',
      'semptom', 'belirti', 'ağrı', 'acı', 'rahatsızlık', 'iyileşme',
      'tedavi olmak', 'ameliyat', 'cerrahi', 'terapi', 'rehabilitasyon',
      // Türkçe çekimler ve varyasyonlar
      'sağlıklı olmak', 'doktora gitmek', 'muayene olmak', 'vitamin almak',
      'iyileşmek', 'tedavi olmak', 'hastaneye gitmek', 'ilaç almak',
      'check-up yaptırmak', 'kontrol olmak', 'hastalık tedavisi',
      'semptom gidermek', 'ağrı gidermek', 'rahatsızlık gidermek',
      'iyileşme süreci', 'tedavi süreci', 'ameliyat olmak', 'cerrahi müdahale',
      'terapi almak', 'rehabilitasyon almak',
      // Yazım hataları ve varyasyonlar
      'sağlıkk', 'doktorra', 'muayenee', 'vitaminn', 'iyileşş',
      'tedavii', 'hastanee', 'ilaçç', 'check-upp', 'kontroll',
      'sağlıklıı', 'hastalıkk', 'semptomm', 'belirtii', 'ağrıı',
      // İngilizce karşılıklar
      'health', 'doctor', 'examination', 'vitamin', 'recover', 'treatment',
      'hospital', 'medicine', 'medication', 'check-up', 'control', 'healthy',
      'disease', 'illness', 'symptom', 'pain', 'discomfort', 'recovery',
      'surgery', 'surgical', 'therapy', 'rehabilitation', 'wellness',
      // Argo/günlük konuşma
      'sağlıklı olmak istiyorum', 'doktora gitmek istiyorum',
      'muayene olmak istiyorum', 'iyileşmek istiyorum', 'tedavi olmak istiyorum',
      'sağlığımı korumak', 'sağlığımı iyileştirmek', 'hastalıktan kurtulmak',
    ],

    'sport': [
      // Türkçe basit formlar
      'koşu', 'yürüyüş', 'spor', 'aktif', 'antrenman', 'futbol', 'basketbol',
      'tenis', 'yüzme', 'bisiklet', 'fitness', 'egzersiz', 'atletizm',
      'maraton', 'koşucu', 'sporcu', 'takım', 'maç', 'oyun', 'rekabet',
      'başarı', 'kazanmak', 'galibiyet', 'şampiyon', 'şampiyonluk',
      // Türkçe çekimler ve varyasyonlar
      'koşmak', 'yürümek', 'spor yapmak', 'aktif olmak', 'antrenman yapmak',
      'futbol oynamak', 'basketbol oynamak', 'tenis oynamak', 'yüzmek',
      'bisiklet sürmek', 'fitness yapmak', 'egzersiz yapmak', 'atletizm yapmak',
      'maraton koşmak', 'koşucu olmak', 'sporcu olmak', 'takım olmak',
      'maç yapmak', 'oyun oynamak', 'rekabet etmek', 'başarı kazanmak',
      'kazanmak', 'galibiyet kazanmak', 'şampiyon olmak', 'şampiyonluk kazanmak',
      // Yazım hataları ve varyasyonlar
      'koşuu', 'yürüyüşş', 'sporr', 'aktiff', 'antrenmann', 'futboll',
      'basketboll', 'teniss', 'yüzmee', 'bisiklett', 'fitnes', 'egzersizz',
      // İngilizce karşılıklar
      'running', 'walking', 'sport', 'active', 'training', 'football', 'soccer',
      'basketball', 'tennis', 'swimming', 'cycling', 'bicycle', 'fitness',
      'exercise', 'athletics', 'marathon', 'runner', 'athlete', 'team',
      'match', 'game', 'competition', 'success', 'win', 'victory', 'champion',
      'championship', 'sports', 'athletic',
      // Argo/günlük konuşma
      'spor yapmak istiyorum', 'koşmak istiyorum', 'yürümek istiyorum',
      'aktif olmak istiyorum', 'sporcu olmak istiyorum', 'şampiyon olmak istiyorum',
      'başarılı olmak istiyorum', 'kazanmak istiyorum', 'galibiyet kazanmak istiyorum',
    ],

    'language': [
      // Türkçe basit formlar
      'ingilizce', 'english', 'almanca', 'language', 'dil', 'konuşmak',
      'öğrenmek', 'öğrenme', 'dil öğrenme', 'yabancı dil', 'çeviri',
      'kelime', 'vocabulary', 'gramer', 'grammar', 'pratik', 'practice',
      'akıcı', 'fluent', 'konuşma', 'speaking', 'yazma', 'writing',
      'okuma', 'reading', 'dinleme', 'listening', 'dil kursu', 'language course',
      // Türkçe çekimler ve varyasyonlar
      'ingilizce öğrenmek', 'almanca öğrenmek', 'fransızca öğrenmek',
      'ispanyolca öğrenmek', 'dil öğrenmek', 'yabancı dil öğrenmek',
      'ingilizce konuşmak', 'almanca konuşmak', 'dil konuşmak',
      'ingilizce yazmak', 'almanca yazmak', 'dil yazmak',
      'ingilizce okumak', 'almanca okumak', 'dil okumak',
      'ingilizce dinlemek', 'almanca dinlemek', 'dil dinlemek',
      'dil kursuna gitmek', 'language course almak', 'pratik yapmak',
      // Yazım hataları ve varyasyonlar
      'ingilizcee', 'englishh', 'almancaa', 'languagee', 'dill',
      'konuşmakk', 'öğrenmekk', 'öğrenmee', 'dil öğrenmee', 'yabancı dill',
      'çevirii', 'kelimee', 'vocabularyy', 'gramerr', 'grammarr',
      // İngilizce karşılıklar
      'english', 'german', 'french', 'spanish', 'language', 'learn',
      'learning', 'foreign language', 'translation', 'vocabulary', 'grammar',
      'practice', 'fluent', 'speaking', 'writing', 'reading', 'listening',
      'language course', 'language learning', 'bilingual', 'multilingual',
      // Argo/günlük konuşma
      'ingilizce öğrenmek istiyorum', 'almanca öğrenmek istiyorum',
      'dil öğrenmek istiyorum', 'yabancı dil öğrenmek istiyorum',
      'ingilizce konuşmak istiyorum', 'akıcı konuşmak istiyorum',
      'dil kursuna gitmek istiyorum', 'pratik yapmak istiyorum',
    ],

    'career': [
      // Türkçe basit formlar
      'kariyer', 'sınav', 'iş', 'ofis', 'terfi', 'cv', 'interview',
      'mülakat', 'başvuru', 'iş başvurusu', 'iş görüşmesi', 'pozisyon',
      'meslek', 'uzman', 'profesyonel', 'kariyer gelişimi', 'terfi almak',
      'maaş', 'salary', 'promotion', 'terfi', 'yükselmek', 'ilerlemek',
      'başarı', 'success', 'hedef', 'goal', 'plan', 'planlama',
      // Türkçe çekimler ve varyasyonlar
      'kariyer yapmak', 'sınav kazanmak', 'iş bulmak', 'işe girmek',
      'ofis çalışmak', 'terfi almak', 'cv hazırlamak', 'interview vermek',
      'mülakat vermek', 'başvuru yapmak', 'iş başvurusu yapmak',
      'iş görüşmesi yapmak', 'pozisyon almak', 'meslek sahibi olmak',
      'uzman olmak', 'profesyonel olmak', 'kariyer geliştirmek',
      'terfi almak', 'maaş almak', 'yükselmek', 'ilerlemek', 'başarı kazanmak',
      // Yazım hataları ve varyasyonlar
      'kariyerr', 'sınavv', 'işş', 'ofiss', 'terfii', 'cvv', 'intervieww',
      'mülakatt', 'başvuruu', 'pozisyonn', 'meslekk', 'uzmann',
      // İngilizce karşılıklar
      'career', 'exam', 'test', 'job', 'work', 'office', 'promotion',
      'cv', 'resume', 'interview', 'application', 'position', 'profession',
      'expert', 'professional', 'career development', 'salary', 'wage',
      'success', 'goal', 'plan', 'planning', 'advancement', 'progress',
      // Argo/günlük konuşma
      'kariyer yapmak istiyorum', 'sınav kazanmak istiyorum',
      'iş bulmak istiyorum', 'işe girmek istiyorum', 'terfi almak istiyorum',
      'başarılı olmak istiyorum', 'yükselmek istiyorum', 'ilerlemek istiyorum',
      'profesyonel olmak istiyorum', 'uzman olmak istiyorum',
    ],

    'relationship': [
      // Türkçe basit formlar
      'aile', 'ilişki', 'sevgili', 'partner', 'dostluk', 'eş', 'evlilik',
      'arkadaş', 'arkadaşlık', 'sosyal', 'iletişim', 'bağ', 'bağlantı',
      'sevgi', 'aşk', 'romantik', 'flört', 'nişan', 'düğün', 'çift',
      'birlikte', 'beraber', 'paylaşmak', 'anlamak', 'desteklemek',
      // Türkçe çekimler ve varyasyonlar
      'aile olmak', 'ilişki kurmak', 'sevgili olmak', 'partner olmak',
      'dostluk kurmak', 'eş olmak', 'evlenmek', 'arkadaş olmak',
      'arkadaşlık kurmak', 'sosyal olmak', 'iletişim kurmak', 'bağ kurmak',
      'sevgi göstermek', 'aşk yaşamak', 'romantik olmak', 'flört etmek',
      'nişanlanmak', 'düğün yapmak', 'çift olmak', 'birlikte olmak',
      'beraber olmak', 'paylaşmak', 'anlamak', 'desteklemek',
      // Yazım hataları ve varyasyonlar
      'ailee', 'ilişkii', 'sevgilii', 'partnerr', 'dostlukk', 'eşş',
      'evlilikk', 'arkadaşş', 'arkadaşlıkk', 'sosyall', 'iletişimm',
      // İngilizce karşılıklar
      'family', 'relationship', 'lover', 'partner', 'friendship', 'spouse',
      'marriage', 'friend', 'social', 'communication', 'bond', 'connection',
      'love', 'romantic', 'dating', 'engagement', 'wedding', 'couple',
      'together', 'share', 'understand', 'support', 'relationship building',
      // Argo/günlük konuşma
      'ilişki kurmak istiyorum', 'sevgili olmak istiyorum',
      'partner olmak istiyorum', 'evlenmek istiyorum', 'arkadaş olmak istiyorum',
      'sosyal olmak istiyorum', 'iletişim kurmak istiyorum', 'bağ kurmak istiyorum',
      'sevgi göstermek istiyorum', 'aşk yaşamak istiyorum', 'romantik olmak istiyorum',
    ],

    'quit_bad_habit': [
      // Türkçe basit formlar
      'sigara', 'alkol', 'bırakmak', 'bağımlılık', 'kötü alışkanlık',
      'alışkanlık', 'bırakma', 'terk etmek', 'vazgeçmek', 'kurtulmak',
      'temizlenmek', 'temiz olmak', 'sağlıklı olmak', 'iyileşmek',
      'bağımlılıktan kurtulmak', 'alışkanlıktan kurtulmak',
      'kötü alışkanlıktan kurtulmak', 'sigara bırakmak', 'alkol bırakmak',
      // Türkçe çekimler ve varyasyonlar
      'sigara bırakmak', 'alkol bırakmak', 'bırakmak', 'bağımlılıktan kurtulmak',
      'alışkanlıktan kurtulmak', 'kötü alışkanlıktan kurtulmak',
      'terk etmek', 'vazgeçmek', 'kurtulmak', 'temizlenmek', 'temiz olmak',
      'sağlıklı olmak', 'iyileşmek', 'bağımlılık tedavisi', 'alışkanlık tedavisi',
      // Yazım hataları ve varyasyonlar
      'sigaraa', 'alkoll', 'bırakmakk', 'bağımlılıkk', 'kötü alışkanlıkk',
      'alışkanlıkk', 'bırakmmaa', 'terk etmekk', 'vazgeçmekk', 'kurtulmakk',
      // İngilizce karşılıklar
      'smoking', 'cigarette', 'alcohol', 'quit', 'addiction', 'bad habit',
      'habit', 'quit smoking', 'quit alcohol', 'stop', 'give up', 'recover',
      'clean', 'healthy', 'recovery', 'addiction treatment', 'habit breaking',
      // Argo/günlük konuşma
      'sigara bırakmak istiyorum', 'alkol bırakmak istiyorum',
      'bırakmak istiyorum', 'bağımlılıktan kurtulmak istiyorum',
      'alışkanlıktan kurtulmak istiyorum', 'kötü alışkanlıktan kurtulmak istiyorum',
      'temiz olmak istiyorum', 'sağlıklı olmak istiyorum', 'iyileşmek istiyorum',
    ],

    'self_improvement': [
      // Türkçe basit formlar
      'gelişim', 'motivasyon', 'özgüven', 'kişisel', 'zihin', 'ruh',
      'kişisel gelişim', 'kendini geliştirmek', 'kendini keşfetmek',
      'kendini tanımak', 'kendini sevmek', 'kendine güvenmek',
      'özgüven kazanmak', 'motivasyon kazanmak', 'başarı kazanmak',
      'hedef koymak', 'plan yapmak', 'disiplin', 'odak', 'konsantrasyon',
      'meditasyon', 'mindfulness', 'farkındalık', 'pozitif düşünce',
      // Türkçe çekimler ve varyasyonlar
      'gelişmek', 'motivasyon kazanmak', 'özgüven kazanmak', 'kişisel gelişim',
      'kendini geliştirmek', 'kendini keşfetmek', 'kendini tanımak',
      'kendini sevmek', 'kendine güvenmek', 'özgüven kazanmak',
      'motivasyon kazanmak', 'başarı kazanmak', 'hedef koymak', 'plan yapmak',
      'disiplin kazanmak', 'odak kazanmak', 'konsantrasyon kazanmak',
      'meditasyon yapmak', 'mindfulness yapmak', 'farkındalık kazanmak',
      'pozitif düşünmek',
      // Yazım hataları ve varyasyonlar
      'gelişimm', 'motivasyonn', 'özgüvenn', 'kişisell', 'zihinn', 'ruhh',
      'kişisel gelişimm', 'kendini geliştirmekk', 'kendini keşfetmekk',
      // İngilizce karşılıklar
      'development', 'growth', 'motivation', 'self-confidence', 'personal',
      'mind', 'spirit', 'self-improvement', 'self-development', 'self-discovery',
      'self-awareness', 'self-love', 'self-confidence', 'confidence',
      'success', 'goal', 'plan', 'discipline', 'focus', 'concentration',
      'meditation', 'mindfulness', 'awareness', 'positive thinking',
      // Argo/günlük konuşma
      'kendini geliştirmek istiyorum', 'kişisel gelişim yapmak istiyorum',
      'özgüven kazanmak istiyorum', 'motivasyon kazanmak istiyorum',
      'başarılı olmak istiyorum', 'hedef koymak istiyorum', 'plan yapmak istiyorum',
      'disiplin kazanmak istiyorum', 'odak kazanmak istiyorum',
    ],

    'travel': [
      // Türkçe basit formlar
      'seyahat', 'tatil', 'gezmek', 'uçak', 'otel', 'turizm', 'turist',
      'gezi', 'yolculuk', 'seyahat etmek', 'tatil yapmak', 'gezmek',
      'dünya', 'ülke', 'şehir', 'kıta', 'kültür', 'deneyim', 'macera',
      'keşfetmek', 'görmek', 'ziyaret etmek', 'gezmek', 'dolaşmak',
      // Türkçe çekimler ve varyasyonlar
      'seyahat etmek', 'tatil yapmak', 'gezmek', 'uçakla gitmek',
      'otel rezervasyonu', 'turizm yapmak', 'turist olmak', 'gezi yapmak',
      'yolculuk yapmak', 'dünya gezmek', 'ülke gezmek', 'şehir gezmek',
      'kıta gezmek', 'kültür keşfetmek', 'deneyim yaşamak', 'macera yaşamak',
      'keşfetmek', 'görmek', 'ziyaret etmek', 'dolaşmak',
      // Yazım hataları ve varyasyonlar
      'seyahatt', 'tatill', 'gezmekk', 'uçakk', 'otell', 'turizmm',
      'turistt', 'gezii', 'yolculukk', 'dünyaa', 'ülkee', 'şehirr',
      // İngilizce karşılıklar
      'travel', 'trip', 'vacation', 'holiday', 'tour', 'tourism', 'tourist',
      'journey', 'flight', 'hotel', 'world', 'country', 'city', 'continent',
      'culture', 'experience', 'adventure', 'explore', 'visit', 'sightseeing',
      // Argo/günlük konuşma
      'seyahat etmek istiyorum', 'tatil yapmak istiyorum', 'gezmek istiyorum',
      'dünya gezmek istiyorum', 'ülke gezmek istiyorum', 'şehir gezmek istiyorum',
      'kültür keşfetmek istiyorum', 'deneyim yaşamak istiyorum',
      'macera yaşamak istiyorum', 'keşfetmek istiyorum', 'görmek istiyorum',
    ],

    'minimalism': [
      // Türkçe basit formlar
      'minimalist', 'düzen', 'temiz', 'toparlamak', 'eşya', 'sadeleştirmek',
      'basitleştirmek', 'azaltmak', 'düzenlemek', 'organize', 'organizasyon',
      'temizlik', 'düzenli', 'sade', 'basit', 'minimal', 'minimal yaşam',
      'sade yaşam', 'basit yaşam', 'düzenli yaşam', 'temiz yaşam',
      'eşya azaltmak', 'eşya toplamak', 'eşya düzenlemek',
      // Türkçe çekimler ve varyasyonlar
      'minimalist olmak', 'düzen kurmak', 'temiz olmak', 'toparlamak',
      'eşya azaltmak', 'sadeleştirmek', 'basitleştirmek', 'azaltmak',
      'düzenlemek', 'organize olmak', 'organizasyon yapmak', 'temizlik yapmak',
      'düzenli olmak', 'sade olmak', 'basit olmak', 'minimal olmak',
      'minimal yaşam', 'sade yaşam', 'basit yaşam', 'düzenli yaşam',
      // Yazım hataları ve varyasyonlar
      'minimalistt', 'düzen', 'temizz', 'toparlamakk', 'eşyaa',
      'sadeleştirmekk', 'basitleştirmekk', 'azaltmakk', 'düzenlemekk',
      // İngilizce karşılıklar
      'minimalist', 'minimalism', 'organization', 'organize', 'clean',
      'tidy', 'simplify', 'simplification', 'reduce', 'declutter',
      'minimal living', 'simple living', 'clean living', 'organized living',
      'minimal lifestyle', 'simple lifestyle', 'clean lifestyle',
      // Argo/günlük konuşma
      'minimalist olmak istiyorum', 'düzen kurmak istiyorum',
      'temiz olmak istiyorum', 'toparlamak istiyorum', 'eşya azaltmak istiyorum',
      'sadeleştirmek istiyorum', 'basitleştirmek istiyorum', 'azaltmak istiyorum',
      'düzenlemek istiyorum', 'organize olmak istiyorum', 'düzenli olmak istiyorum',
    ],
  };

  /// Belirli bir kategori için anahtar kelimeleri döndürür
  static List<String> getKeywordsForCategory(String categoryId) {
    return keywords[categoryId] ?? [];
  }

  /// Tüm kategoriler için anahtar kelimeleri döndürür
  static Map<String, List<String>> getAllKeywords() {
    return keywords;
  }
}



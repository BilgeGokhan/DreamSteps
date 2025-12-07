import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category_match_result.dart';

/// DreamSteps Category Matching Engine (V3 Hyper-Smart)
/// 
/// Implements a sophisticated multi-tier scoring system for category detection:
/// 1. HARD KEYWORDS (exact match): +10 each
/// 2. BASE KEYWORDS (exact match): +5 each
/// 3. PHRASES (full contains): +7 each
/// 4. STEM MATCH (word startsWith stem): +3 each
/// 5. REGEX MATCH (pattern matches): +5 each
/// 6. FUZZY MATCH (Levenshtein similarity >= 0.8): +2 each
/// 
/// Final score is multiplied by category weight.
/// Returns category with highest score, or fallback to "self_improvement" if:
/// - Score difference < 0.5 between top two categories
/// - Top score < 2.0
class CategoryDetectionService {
  /// Minimum fuzzy matching similarity threshold (0.0 - 1.0)
  static const double _fuzzySimilarityThreshold = 0.8;

  /// Minimum score threshold for category selection
  static const double _minScoreThreshold = 2.0;

  /// Minimum score difference between top two categories
  static const double _minScoreDifference = 0.5;

  /// Loaded keywords V3 data
  static Map<String, dynamic>? _keywordsV3Data;

  /// Load keywords V3 from assets
  static Future<void> loadKeywordsV3() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/keywords_v3.json');
      _keywordsV3Data = json.decode(jsonString) as Map<String, dynamic>;
      debugPrint('CategoryDetectionService: Loaded keywords_v3.json with ${_keywordsV3Data!.length} categories');
    } catch (e) {
      debugPrint('CategoryDetectionService: Error loading keywords_v3.json: $e');
      _keywordsV3Data = null;
      rethrow;
    }
  }

  /// Set keywords V3 data (for testing or manual loading)
  static void setKeywordsV3(Map<String, dynamic> data) {
    _keywordsV3Data = data;
  }

  /// Detect category from user dream text
  /// 
  /// [dream] User-entered dream string
  /// 
  /// Returns: CategoryMatchResult with detected category, confidence, and all scores
  static Future<CategoryMatchResult> detectCategory(String dream) async {
    // Load keywords if not already loaded
    if (_keywordsV3Data == null) {
      await loadKeywordsV3();
    }

    // Empty input fallback
    if (dream.trim().isEmpty) {
      debugPrint('CategoryDetectionService: Empty input, using fallback');
      return CategoryMatchResult(
        category: 'self_improvement',
        confidence: 0.0,
        scores: {},
      );
    }

    // Normalize input text
    final normalizedText = normalizeText(dream);
    final tokens = normalizedText.split(' ').where((t) => t.isNotEmpty).toList();
    final filteredTokens = removeStopwords(tokens);

    debugPrint('CategoryDetectionService: Normalized text: "$normalizedText"');
    debugPrint('CategoryDetectionService: Tokens: $filteredTokens');
    debugPrint('CategoryDetectionService: Filtered tokens: $filteredTokens');

    // SPECIAL CASE: Early detection for language category
    // Check in both original text, normalized text, and tokens
    final originalLower = dream.toLowerCase().trim();
    const languageKeywords = [
      'ingilizce', 'english', 'almanca', 'deutsch', 'fransızca', 'ispanyolca', 
      'italyanca', 'dil', 'language', 'toefl', 'ielts', 'speaking', 'listening',
      'yabancı dil', 'dil öğrenmek', 'ingilizce öğrenmek', 'almanca öğrenmek',
      'fransızca öğrenmek', 'ispanyolca öğrenmek', 'italyanca öğrenmek',
      'ingiliz', 'almanc', 'fransız', 'ispanyol', 'italyan',
      'vocabulary', 'grammar', 'pronunciation', 'fluent', 'bilingual',
      'dil öğren', 'dil geliştirmek', 'yabancı dil öğrenmek'
    ];
    
    bool isLanguage = false;
    String? matchedKeyword;
    
    // Check each keyword
    for (final keyword in languageKeywords) {
      final keywordLower = keyword.toLowerCase();
      
      // Check in original text (case insensitive)
      if (originalLower.contains(keywordLower)) {
        isLanguage = true;
        matchedKeyword = keyword;
        break;
      }
      
      // Check in normalized text
      if (normalizedText.contains(keywordLower)) {
        isLanguage = true;
        matchedKeyword = keyword;
        break;
      }
      
      // Check in tokens (exact match)
      if (tokens.contains(keywordLower)) {
        isLanguage = true;
        matchedKeyword = keyword;
        break;
      }
      
      // Check in filtered tokens (exact match)
      if (filteredTokens.contains(keywordLower)) {
        isLanguage = true;
        matchedKeyword = keyword;
        break;
      }
      
      // Check if keyword is a single word and matches any token
      if (keywordLower.split(' ').length == 1) {
        for (final token in tokens) {
          if (token == keywordLower || token.startsWith(keywordLower) || keywordLower.startsWith(token)) {
            isLanguage = true;
            matchedKeyword = keyword;
            break;
          }
        }
        if (isLanguage) break;
      }
    }
    
    if (isLanguage) {
      debugPrint('CategoryDetectionService: Early detection - Language keyword "$matchedKeyword" found');
      debugPrint('CategoryDetectionService: Original: "$dream"');
      debugPrint('CategoryDetectionService: Normalized: "$normalizedText"');
      debugPrint('CategoryDetectionService: Tokens: $tokens');
      debugPrint('CategoryDetectionService: Filtered tokens: $filteredTokens');
      debugPrint('CategoryDetectionService: Returning language category with score 1000.0');
      return CategoryMatchResult(
        category: 'language',
        confidence: 0.95,
        scores: {'language': 1000.0}, // Very high score to ensure it wins
      );
    }

    // Calculate scores for each category
    final categoryScores = <String, double>{};

    // SPECIAL: Check language category FIRST and give it massive priority
    final languageData = _keywordsV3Data!['language'] as Map<String, dynamic>?;
    if (languageData != null) {
      final languageScore = scoreForCategory(languageData, filteredTokens, normalizedText);
      // If language has ANY score, multiply it by 10 to ensure it wins
      if (languageScore > 0) {
        categoryScores['language'] = languageScore * 10.0;
        debugPrint('CategoryDetectionService: Language category score: $languageScore, multiplied to: ${languageScore * 10.0}');
      }
    }

    _keywordsV3Data!.forEach((categoryId, categoryData) {
      // Skip language, already processed
      if (categoryId == 'language') return;
      
      if (categoryData is Map<String, dynamic>) {
        final score = scoreForCategory(categoryData, filteredTokens, normalizedText);
        if (score > 0) {
          categoryScores[categoryId] = score;
        }
      }
    });

    debugPrint('CategoryDetectionService: Category scores: $categoryScores');

    // Find top two categories
    if (categoryScores.isEmpty) {
      debugPrint('CategoryDetectionService: No scores, using fallback');
      return CategoryMatchResult(
        category: 'self_improvement',
        confidence: 0.0,
        scores: categoryScores,
      );
    }

    // Sort by score descending
    final sortedEntries = categoryScores.entries.toList()
      ..sort((a, b) {
        // Special priority for language category if it has any score
        if (a.key == 'language' && a.value > 0 && b.key != 'language') {
          return -1; // language comes first
        }
        if (b.key == 'language' && b.value > 0 && a.key != 'language') {
          return 1; // language comes first
        }
        return b.value.compareTo(a.value);
      });

    final topCategory = sortedEntries[0];
    final topScore = topCategory.value;
    final topCategoryId = topCategory.key;

    // Check fallback conditions
    bool useFallback = false;

    // Check if top score is below threshold
    if (topScore < _minScoreThreshold) {
      debugPrint('CategoryDetectionService: Top score ($topScore) below threshold ($_minScoreThreshold), using fallback');
      useFallback = true;
    }

    // Check if score difference is too small (if there's a second category)
    if (!useFallback && sortedEntries.length > 1) {
      final secondScore = sortedEntries[1].value;
      final scoreDifference = topScore - secondScore;
      // Special case: If language category has any score and is close to top, prefer language
      final languageScore = categoryScores['language'] ?? 0.0;
      if (languageScore > 0 && topCategoryId != 'language' && (topScore - languageScore) < 5.0) {
        debugPrint('CategoryDetectionService: Language category has score $languageScore, preferring language over $topCategoryId');
        return CategoryMatchResult(
          category: 'language',
          confidence: 0.8,
          scores: categoryScores,
        );
      }
      if (scoreDifference < _minScoreDifference) {
        debugPrint('CategoryDetectionService: Score difference ($scoreDifference) too small, using fallback');
        useFallback = true;
      }
    }

    final selectedCategory = useFallback ? 'self_improvement' : topCategoryId;
    
    // Calculate confidence (0.0 - 1.0)
    // Confidence is based on how much higher the top score is compared to others
    double confidence = 0.0;
    if (categoryScores.isNotEmpty) {
      if (categoryScores.length == 1) {
        confidence = 1.0;
      } else {
        final maxScore = categoryScores.values.reduce((a, b) => a > b ? a : b);
        final secondMaxScore = categoryScores.values
            .where((s) => s < maxScore)
            .fold<double>(0.0, (a, b) => a > b ? a : b);
        if (maxScore > 0) {
          confidence = (maxScore - secondMaxScore) / maxScore;
          confidence = confidence.clamp(0.0, 1.0);
        }
      }
    }

    debugPrint('CategoryDetectionService: Selected category: "$selectedCategory" with confidence: $confidence');

    return CategoryMatchResult(
      category: selectedCategory,
      confidence: confidence,
      scores: categoryScores,
    );
  }

  /// Normalize input text:
  /// - toLowerCase (Turkish)
  /// - remove punctuation
  /// - collapse spaces
  /// - tokenize by space
  static String normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '') // Remove punctuation
        .replaceAll(RegExp(r'\s+'), ' ') // Collapse spaces
        .trim();
  }

  /// Remove stopwords from token list
  static List<String> removeStopwords(List<String> tokens) {
    const stopwords = [
      'istiyorum',
      'istiyom',
      'istiorum',
      'istiyorummm',
      'yapmak',
      'etmek',
      'başlamak',
      'öğrenmek',
      'çok',
      'fazla',
      'biraz',
      've',
      'ile',
    ];
    return tokens.where((token) => !stopwords.contains(token)).toList();
  }

  /// Calculate Levenshtein distance between two strings
  static int levenshteinDistance(String a, String b) {
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final matrix = List.generate(
      a.length + 1,
      (i) => List.generate(b.length + 1, (j) => 0),
    );

    for (int i = 0; i <= a.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= b.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1, // deletion
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[a.length][b.length];
  }

  /// Calculate fuzzy similarity (Levenshtein-based) between two strings
  /// Returns similarity score 0.0 - 1.0
  static double fuzzySimilarity(String a, String b) {
    if (a.isEmpty && b.isEmpty) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;
    if (a == b) return 1.0;

    final distance = levenshteinDistance(a, b);
    final maxLength = a.length > b.length ? a.length : b.length;
    return 1.0 - (distance / maxLength);
  }

  /// Score a category based on its rules
  /// 
  /// [rules] Category rules from JSON (hard_keywords, base_keywords, phrases, stems, regex, weight)
  /// [tokens] Normalized and filtered tokens from input text
  /// [text] Full normalized text
  /// 
  /// Returns: Total score for this category (before weight multiplication)
  static double scoreForCategory(
    Map<String, dynamic> rules,
    List<String> tokens,
    String text,
  ) {
    double score = 0.0;

    // HARD KEYWORDS (exact match): +10 each
    final hardKeywords = (rules['hard_keywords'] as List<dynamic>?)?.cast<String>() ?? [];
    for (final keyword in hardKeywords) {
      final normalizedKeyword = normalizeText(keyword);
      // Check exact match: either full text matches or keyword is contained exactly in text
      // For single-word keywords, also check in tokens for better matching
      final keywordWords = normalizedKeyword.split(' ');
      final isSingleWord = keywordWords.length == 1;
      
      bool matches = false;
      if (text == normalizedKeyword) {
        matches = true;
      } else if (text.contains(normalizedKeyword)) {
        matches = true;
      } else if (isSingleWord && tokens.contains(normalizedKeyword)) {
        matches = true;
      }
      
      if (matches) {
        score += 10.0;
        debugPrint('CategoryDetectionService: HARD KEYWORD match: "$keyword" (+10)');
      }
    }

    // BASE KEYWORDS (exact match): +5 each
    // Also check "keywords" field for backward compatibility
    final baseKeywordsList = (rules['base_keywords'] as List<dynamic>?)?.cast<String>() ?? [];
    final keywordsList = (rules['keywords'] as List<dynamic>?)?.cast<String>() ?? [];
    final baseKeywords = [...baseKeywordsList, ...keywordsList];
    
    for (final keyword in baseKeywords) {
      final normalizedKeyword = normalizeText(keyword);
      // Check exact match in tokens
      if (tokens.contains(normalizedKeyword)) {
        score += 5.0;
        debugPrint('CategoryDetectionService: BASE KEYWORD match: "$keyword" (+5)');
      }
    }

    // PHRASES (full contains): +7 each
    final phrases = (rules['phrases'] as List<dynamic>?)?.cast<String>() ?? [];
    for (final phrase in phrases) {
      final normalizedPhrase = normalizeText(phrase);
      if (text.contains(normalizedPhrase)) {
        score += 7.0;
        debugPrint('CategoryDetectionService: PHRASE match: "$phrase" (+7)');
      }
    }

    // STEM MATCH (word startsWith stem): +3 each
    final stems = (rules['stems'] as List<dynamic>?)?.cast<String>() ?? [];
    for (final stem in stems) {
      final normalizedStem = normalizeText(stem);
      // Check if any token starts with this stem
      for (final token in tokens) {
        if (token.startsWith(normalizedStem)) {
          score += 3.0;
          debugPrint('CategoryDetectionService: STEM match: "$stem" in "$token" (+3)');
          break; // Only count once per stem
        }
      }
    }

    // REGEX MATCH (pattern matches): +5 each
    final regexPatterns = (rules['regex'] as List<dynamic>?)?.cast<String>() ?? [];
    for (final pattern in regexPatterns) {
      try {
        final regex = RegExp(pattern, caseSensitive: false);
        if (regex.hasMatch(text)) {
          score += 5.0;
          debugPrint('CategoryDetectionService: REGEX match: "$pattern" (+5)');
        }
      } catch (e) {
        debugPrint('CategoryDetectionService: Invalid regex pattern "$pattern": $e');
      }
    }

    // FUZZY MATCH (Levenshtein similarity >= 0.8): +2 each
    // Check all keywords against all tokens
    final allKeywords = [
      ...hardKeywords,
      ...baseKeywords,
      ...phrases.map((p) => p.split(' ').first), // Use first word of phrases
    ];

    for (final keyword in allKeywords) {
      final normalizedKeyword = normalizeText(keyword);
      for (final token in tokens) {
        final similarity = fuzzySimilarity(normalizedKeyword, token);
        if (similarity >= _fuzzySimilarityThreshold) {
          score += 2.0;
          debugPrint('CategoryDetectionService: FUZZY match: "$keyword" ~ "$token" (similarity: $similarity) (+2)');
          break; // Only count once per keyword
        }
      }
    }

    // Multiply by category weight
    final weight = (rules['weight'] as num?)?.toDouble() ?? 1.0;
    final finalScore = score * weight;

    debugPrint('CategoryDetectionService: Category score: $score, weight: $weight, final: $finalScore');

    return finalScore;
  }
}

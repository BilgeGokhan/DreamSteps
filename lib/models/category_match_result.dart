/// Category matching result model
/// Contains the detected category, confidence score, and all category scores
class CategoryMatchResult {
  final String category;
  final double confidence;
  final Map<String, double> scores;

  CategoryMatchResult({
    required this.category,
    required this.confidence,
    required this.scores,
  });

  @override
  String toString() {
    return 'CategoryMatchResult(category: $category, confidence: $confidence, scores: $scores)';
  }
}


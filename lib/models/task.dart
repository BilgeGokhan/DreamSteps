class Task {
  final Map<String, String> title; // { 'tr': '...', 'en': '...', 'de': '...' }
  final Map<String, String> detail; // { 'tr': '...', 'en': '...', 'de': '...' }

  Task({
    required this.title,
    required this.detail,
  });

  /// Get title in specified language, fallback to Turkish if not available
  String getTitle(String languageCode) {
    return title[languageCode] ?? title['tr'] ?? title['en'] ?? '';
  }

  /// Get detail in specified language, fallback to Turkish if not available
  String getDetail(String languageCode) {
    return detail[languageCode] ?? detail['tr'] ?? detail['en'] ?? '';
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    // Support both old format (String) and new format (Map<String, String>)
    Map<String, String> titleMap;
    Map<String, String> detailMap;

    // Handle title
    if (json['title'] is Map) {
      titleMap = Map<String, String>.from(json['title'] as Map);
    } else if (json['title'] is String) {
      // Old format: single string, assume Turkish
      titleMap = {
        'tr': json['title'] as String,
        'en': json['title'] as String, // Fallback to same text
        'de': json['title'] as String, // Fallback to same text
      };
    } else {
      titleMap = {'tr': '', 'en': '', 'de': ''};
    }

    // Handle detail
    if (json['detail'] is Map) {
      detailMap = Map<String, String>.from(json['detail'] as Map);
    } else if (json['detail'] is String) {
      // Old format: single string, assume Turkish
      detailMap = {
        'tr': json['detail'] as String,
        'en': json['detail'] as String, // Fallback to same text
        'de': json['detail'] as String, // Fallback to same text
      };
    } else {
      detailMap = {'tr': '', 'en': '', 'de': ''};
    }

    return Task(
      title: titleMap,
      detail: detailMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'detail': detail,
    };
  }
}






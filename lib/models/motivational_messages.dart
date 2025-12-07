class MotivationalMessages {
  final Map<String, List<String>> messagesByCategory;

  MotivationalMessages({required this.messagesByCategory});

  List<String>? getMessagesForCategory(String categoryId) {
    return messagesByCategory[categoryId];
  }

  bool hasMessagesForCategory(String categoryId) {
    return messagesByCategory.containsKey(categoryId) &&
        messagesByCategory[categoryId]!.isNotEmpty;
  }
}


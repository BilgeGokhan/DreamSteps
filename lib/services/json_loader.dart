import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/category_model.dart';
import '../models/task_package.dart';
import '../models/completion_config.dart';

class JsonLoader {
  /// Loads categories from assets/json/categories.json
  static Future<List<DreamCategory>> loadCategories() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/categories.json');
      final dynamic jsonData = json.decode(jsonString);

      // Handle both array and object structures
      List<dynamic> categoriesList;
      if (jsonData is List) {
        categoriesList = jsonData;
      } else if (jsonData is Map<String, dynamic>) {
        if (jsonData.containsKey('categories')) {
          categoriesList = jsonData['categories'] as List<dynamic>;
        } else {
          // Try to parse as a list directly
          categoriesList = jsonData.values.toList();
        }
      } else {
        throw Exception('Unexpected JSON structure for categories');
      }

      return categoriesList.map((item) {
        final json = item as Map<String, dynamic>;
        // Use fromJson factory method which handles all fields including colors
        return DreamCategory.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  /// Loads keywords from assets/json/keywords.json
  /// Returns a map of categoryId -> list of keywords
  static Future<Map<String, List<String>>> loadKeywords() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/keywords.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Assuming keywords.json structure is:
      // { "categoryId": ["keyword1", "keyword2", ...], ... }
      final Map<String, List<String>> keywordsMap = {};

      jsonData.forEach((key, value) {
        if (value is List) {
          keywordsMap[key] = value.cast<String>();
        }
      });

      return keywordsMap;
    } catch (e) {
      throw Exception('Failed to load keywords: $e');
    }
  }

  /// Loads keywords V3 from assets/json/keywords_v3.json
  /// Returns the full JSON structure with all rules (hard_keywords, base_keywords, phrases, stems, regex, weight)
  static Future<Map<String, dynamic>> loadKeywordsV3() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/keywords_v3.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return jsonData;
    } catch (e) {
      debugPrint('loadKeywordsV3: Error loading JSON: $e');
      throw Exception('Failed to load keywords_v3: $e');
    }
  }

  /// Loads task packages from assets/json/tasks.json
  /// Returns a map of categoryId -> Map<packageId, TaskPackage>
  /// Supports structure: { "categoryId": { "A": { "tasks": [...] }, "B": { "tasks": [...] }, ... } }
  /// or: { "categoryId": { "package": "A", "tasks": [...] } } (old structure for backward compatibility)
  static Future<Map<String, Map<String, TaskPackage>>>
      loadTaskPackages() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/tasks.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final Map<String, Map<String, TaskPackage>> packagesMap = {};

      jsonData.forEach((categoryId, categoryData) {
        if (categoryData is Map<String, dynamic>) {
          final categoryPackages = <String, TaskPackage>{};

          // Check if it's the new structure with A, B, C packages
          if (categoryData.containsKey('A') ||
              categoryData.containsKey('B') ||
              categoryData.containsKey('C')) {
            // New structure: { "A": { "tasks": [...] }, ... }
            // Package ID key'den alınır, "package" parametresine gerek yok
            for (final packageKey in ['A', 'B', 'C']) {
              final packageData =
                  categoryData[packageKey] as Map<String, dynamic>?;
              if (packageData != null) {
                categoryPackages[packageKey] = TaskPackage.fromJson(
                  categoryId,
                  packageKey,
                  packageData,
                );
              }
            }
          } else {
            // Old structure: { "package": "A", "tasks": [...] } (geriye dönük uyumluluk)
            final packageId = categoryData['package'] as String? ?? 'A';
            categoryPackages[packageId] = TaskPackage.fromJson(
              categoryId,
              packageId,
              categoryData,
            );
          }

          if (categoryPackages.isNotEmpty) {
            packagesMap[categoryId] = categoryPackages;
          }
        }
      });

      return packagesMap;
    } catch (e) {
      throw Exception('Failed to load task packages: $e');
    }
  }

  /// Loads motivational messages from assets/json/motivational_messages.json
  /// Returns a map of categoryId -> list of message maps {tr, en, de}
  static Future<Map<String, List<Map<String, String>>>> loadMotivationalMessages() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/motivational_messages.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Support both old format (List<String>) and new format (List<Map<String, String>>)
      final Map<String, List<Map<String, String>>> messagesMap = {};

      jsonData.forEach((key, value) {
        if (value is List) {
          final List<Map<String, String>> messageList = [];
          for (var item in value) {
            if (item is Map) {
              // New format: { "tr": "...", "en": "...", "de": "..." }
              messageList.add(Map<String, String>.from(item));
            } else if (item is String) {
              // Old format: single string, assume Turkish
              messageList.add({
                'tr': item,
                'en': item, // Fallback to same text
                'de': item, // Fallback to same text
              });
            }
          }
          messagesMap[key] = messageList;
          debugPrint(
              'loadMotivationalMessages: Loaded ${messageList.length} messages for category: $key');
        } else {
          debugPrint(
              'loadMotivationalMessages: Warning - value for category "$key" is not a List, type: ${value.runtimeType}');
        }
      });

      debugPrint(
          'loadMotivationalMessages: Total categories loaded: ${messagesMap.length}');
      return messagesMap;
    } catch (e) {
      debugPrint('loadMotivationalMessages: Error loading JSON: $e');
      throw Exception('Failed to load motivational messages: $e');
    }
  }

  /// Loads completion configs from assets/json/completion_screens.json
  /// Returns a map of categoryId -> CompletionConfig
  static Future<Map<String, CompletionConfig>> loadCompletionConfigs() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/completion_screens.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // Assuming structure: { "categoryId": { "color": "...", "animation": "...", ... }, ... }
      final Map<String, CompletionConfig> configsMap = {};

      jsonData.forEach((categoryId, configData) {
        if (configData is Map<String, dynamic>) {
          // Map the JSON structure to CompletionConfig format
          // JSON has: "soft", "motivation", "pro"
          // Model expects: "message_soft", "message_motivational", "message_pro"
          final mappedData = <String, dynamic>{
            'color': configData['color'] ?? '#845EF7', // Default color
            'animation': configData['animation'] ?? '', // Default empty
            'message_soft':
                configData['soft'] ?? configData['message_soft'] ?? '',
            'message_motivational': configData['motivation'] ??
                configData['message_motivational'] ??
                '',
            'message_pro': configData['pro'] ?? configData['message_pro'] ?? '',
            'cta': configData['cta'] ?? 'Devam Et', // Default CTA
          };
          configsMap[categoryId] = CompletionConfig.fromJson(mappedData);
        }
      });

      return configsMap;
    } catch (e) {
      throw Exception('Failed to load completion configs: $e');
    }
  }
}

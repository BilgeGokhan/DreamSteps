import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageState extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  Locale _locale = const Locale('tr'); // Default to Turkish

  Locale get locale => _locale;

  LanguageState() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey);
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  Future<void> setLanguage(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
  }
}


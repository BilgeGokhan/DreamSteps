import 'package:flutter/material.dart';

class DreamCategory {
  final String id;
  final String name;
  final String primaryColor;
  final String backgroundColor;
  final String? icon;
  final String? animation;

  DreamCategory({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.backgroundColor,
    this.icon,
    this.animation,
  });

  factory DreamCategory.fromJson(Map<String, dynamic> json) {
    return DreamCategory(
      id: json['id'] as String,
      name: json['name'] as String? ?? json['title'] as String? ?? '',
      primaryColor: json['primaryColor'] as String? ?? '#4C6EF5',
      backgroundColor: json['backgroundColor'] as String? ?? '#F6F7FB',
      icon: json['icon'] as String?,
      animation: json['animation'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'primaryColor': primaryColor,
      'backgroundColor': backgroundColor,
      if (icon != null) 'icon': icon,
      if (animation != null) 'animation': animation,
    };
  }

  /// Hex string'i Color'a çevirir
  Color get primaryColorValue {
    try {
      return Color(int.parse(primaryColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF4C6EF5); // Default color
    }
  }

  /// Hex string'i Color'a çevirir
  Color get backgroundColorValue {
    try {
      return Color(int.parse(backgroundColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFFF6F7FB); // Default color
    }
  }

  /// Kategori icon'unu döndürür (Material Icons fallback ile)
  IconData get iconData {
    // Icon path'inden Material Icon'a mapping
    switch (id) {
      case 'finance':
        return Icons.account_balance_wallet;
      case 'car_home':
        return Icons.directions_car;
      case 'fitness':
        return Icons.fitness_center;
      case 'health':
        return Icons.favorite;
      case 'sport':
        return Icons.sports_soccer;
      case 'language':
        return Icons.language;
      case 'career':
        return Icons.work;
      case 'relationship':
        return Icons.favorite_border;
      case 'quit_bad_habit':
        return Icons.smoke_free;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'travel':
        return Icons.flight;
      case 'minimalism':
        return Icons.cleaning_services;
      default:
        return Icons.auto_awesome;
    }
  }

  /// Icon widget'ı döndürür (asset image veya Material Icon)
  Widget getIconWidget({double size = 24, Color? color}) {
    // Eğer icon path varsa ve dosya mevcutsa asset image kullan
    if (icon != null && icon!.isNotEmpty) {
      return Image.asset(
        'assets/$icon',
        width: size,
        height: size,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          // Asset yüklenemezse Material Icon göster
          return Icon(
            iconData,
            size: size,
            color: color,
          );
        },
      );
    }
    // Icon yoksa Material Icon göster
    return Icon(
      iconData,
      size: size,
      color: color,
    );
  }
}


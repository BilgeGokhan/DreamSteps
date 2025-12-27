import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/dream_state.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';
import '../services/notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animasyonu hemen başlat (build çağrılmadan önce)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();

    // Widget build edildikten sonra async işlemleri başlat (Provider context hazır olmalı)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Context'in hazır olduğundan emin ol
      if (!mounted) return;
      
      final dreamState = Provider.of<DreamState>(context, listen: false);

      // Initialize JSON data with timeout (daha kısa timeout - hızlı başlatma)
      final languageState = Provider.of<LanguageState>(context, listen: false);
      final localizations = AppLocalizations(languageState.locale);
      
      // Paralel olarak initialize et ve load et
      final initFuture = dreamState.initialize().timeout(
        const Duration(seconds: 5), // Timeout'u 5 saniyeye düşür
        onTimeout: () {
          debugPrint('SplashScreen: Initialize timeout!');
          throw TimeoutException(localizations.splashLoadingTimeout);
        },
      );

      // Initialize tamamlanır tamamlanmaz load et
      await initFuture;
      await dreamState.loadFromLocal();

      // Bildirimleri schedule et (dreamText olsun ya da olmasın)
      NotificationService.scheduleDailyReminder(
        dreamText: dreamState.dreamText,
      ).catchError((e) {
        debugPrint('SplashScreen: Error scheduling notification: $e');
      });

      // Minimum delay ile hızlı geçiş (1 saniye yeterli)
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          _navigateToNext();
        }
      });
    } catch (e) {
      debugPrint('SplashScreen: Error during initialization: $e');
      // Hata durumunda bile dil seçim ekranına git (kullanıcı deneyimini bozmamak için)
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed('/language_selection');
          }
        });
      }
    }
  }

  void _navigateToNext() {
    if (!mounted) return;
    
    final dreamState = Provider.of<DreamState>(context, listen: false);
    if (dreamState.dreamText != null && dreamState.dreamText!.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      Navigator.of(context).pushReplacementNamed('/language_selection');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageState>(
      builder: (context, languageState, child) {
        final localizations = AppLocalizations.of(context) ?? 
            AppLocalizations(languageState.locale);
        final appName = localizations.splashAppName;
        
        return Scaffold(
      backgroundColor: const Color(0xFF4C6EF5),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon placeholder
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: Color(0xFF4C6EF5),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                appName,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
        );
      },
    );
  }
}

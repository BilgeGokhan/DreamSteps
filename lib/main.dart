import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'state/dream_state.dart';
import 'state/language_state.dart';
import 'l10n/app_localizations.dart';
import 'screens/splash_screen.dart';
import 'screens/language_selection_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/dream_input_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/all_steps_screen.dart';
import 'screens/about_screen.dart';
import 'services/notification_service.dart';
import 'services/ad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Bildirim servisini başlat
  await NotificationService.initialize();
  
  // AdMob'u başlat
  await AdService.initialize();
  
  runApp(const DreamStepsApp());
}

class DreamStepsApp extends StatelessWidget {
  const DreamStepsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DreamState()),
        ChangeNotifierProvider(create: (_) => LanguageState()),
      ],
      child: Consumer<LanguageState>(
        builder: (context, languageState, child) {
    return MaterialApp(
      title: 'DreamSteps',
      debugShowCheckedModeBanner: false,
            locale: languageState.locale,
            supportedLocales: const [
              Locale('tr'),
              Locale('en'),
              Locale('de'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4C6EF5),
          brightness: Brightness.light,
        ),
              scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        textTheme: GoogleFonts.interTextTheme(),
              primaryColor: const Color(0xFF4C6EF5),
              cardColor: Colors.white,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4C6EF5),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeMode.system,
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => const SplashScreen(),
              '/language_selection': (context) => const LanguageSelectionScreen(),
              '/onboarding': (context) => const OnboardingScreen(),
              '/dream_input': (context) => const DreamInputScreen(),
              '/dashboard': (context) => const DashboardScreen(),
              '/statistics': (context) => const StatisticsScreen(),
              '/all_steps': (context) => const AllStepsScreen(),
              '/about': (context) => const AboutScreen(),
            },
          );
        },
      ),
    );
  }
}

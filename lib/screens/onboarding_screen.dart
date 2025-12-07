import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPage> _buildPages(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? 
        AppLocalizations(Provider.of<LanguageState>(context, listen: false).locale);
    
    return [
      OnboardingPage(
        title: localizations.onboardingPage1Title,
        description: localizations.onboardingPage1Description,
      ),
      OnboardingPage(
        title: localizations.onboardingPage2Title,
        description: localizations.onboardingPage2Description,
      ),
      OnboardingPage(
        title: localizations.onboardingPage3Title,
        description: localizations.onboardingPage3Description,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed('/dream_input');
  }

  void _continue(BuildContext context) {
    final pages = _buildPages(context);
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageState>(
      builder: (context, languageState, child) {
        final localizations = AppLocalizations.of(context) ?? 
            AppLocalizations(languageState.locale);
        final pages = _buildPages(context);
        
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          body: SafeArea(
            child: Column(
              children: [
                // Skip button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: _skip,
                      child: Text(
                        localizations.onboardingSkip,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: pages.length,
                    itemBuilder: (context, index) => pages[index],
                  ),
                ),
                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFF4C6EF5)
                            : const Color(0xFF4C6EF5).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Continue/Get Started button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _continue(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C6EF5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        _currentPage == pages.length - 1
                            ? localizations.onboardingStart
                            : localizations.onboardingContinue,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFF4C6EF5).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 100,
              color: Color(0xFF4C6EF5),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF111827).withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}


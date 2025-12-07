import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/language_state.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Her buton için ayrı animasyon
    _animations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.15,
            0.5 + (index * 0.2),
            curve: Curves.elasticOut,
          ),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectLanguage(Locale locale) async {
    final languageState = Provider.of<LanguageState>(context, listen: false);
    await languageState.setLanguage(locale);
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6B8AFF), // Açık mavi-mor (ana rengin açık tonu)
              const Color(0xFF5B7AEF), // Orta mavi-mor
              const Color(0xFF4C6EF5), // Ana uygulama rengi
              const Color(0xFF3D5EDF), // Koyu mavi-mor
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dil seçenekleri - Her biri tıklanabilir
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Column(
                      children: [
                        _buildLanguageButton(
                          'Merhaba',
                          const Locale('tr'),
                          0,
                        ),
                        const SizedBox(height: 32),
                        _buildLanguageButton(
                          'Hello',
                          const Locale('en'),
                          1,
                        ),
                        const SizedBox(height: 32),
                        _buildLanguageButton(
                          'Hallo',
                          const Locale('de'),
                          2,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(
    String text,
    Locale locale,
    int index,
  ) {
    final isHovered = _hoveredIndex == index;
    
    return ScaleTransition(
      scale: _animations[index],
      child: FadeTransition(
        opacity: _animations[index],
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween(begin: 1.0, end: isHovered ? 1.08 : 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _selectLanguage(locale),
                  onTapDown: (_) {
                    setState(() => _hoveredIndex = index);
                  },
                  onTapUp: (_) {
                    setState(() => _hoveredIndex = null);
                  },
                  onTapCancel: () {
                    setState(() => _hoveredIndex = null);
                  },
                  borderRadius: BorderRadius.circular(0),
                  splashColor: Colors.white.withOpacity(0.2),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    child: Center(
                      child: Text(
                        text,
                        style: GoogleFonts.dancingScript(
                          fontSize: 72,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


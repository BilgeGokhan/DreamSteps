import 'dart:math';
import 'package:flutter/material.dart';

/// Dummy ad banner widget for placeholder purposes.
/// 
/// This widget displays a placeholder for future AdMob integration.
/// It provides a consistent UI structure that can be easily replaced
/// with real ad banners when ads are enabled.
/// 
/// TODO(Miro): Replace DummyAdBanner with real AdMob banner when ads are enabled.
class DummyAdBanner extends StatefulWidget {
  /// Height of the banner. Default is 110px.
  final double height;

  /// Border radius for rounded corners. Default is 16px.
  final double borderRadius;

  const DummyAdBanner({
    super.key,
    this.height = 110,
    this.borderRadius = 16,
  });

  @override
  State<DummyAdBanner> createState() => _DummyAdBannerState();
}

class _DummyAdBannerState extends State<DummyAdBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late String _selectedImage;
  
  // Rastgele reklam görselleri listesi
  static const List<String> _adImages = [
    'assets/dummy_ads/banner1.png',
    'assets/dummy_ads/banner2.png',
    'assets/dummy_ads/sample_ad.png',
  ];

  @override
  void initState() {
    super.initState();
    
    // Rastgele bir reklam görseli seç
    final random = Random();
    _selectedImage = _adImages[random.nextInt(_adImages.length)];
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF2C2C2C)
              : Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isDark
                ? const Color(0xFF404040)
                : const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            children: [
              // Ana reklam görseli (veya renkli placeholder)
              _buildAdImage(isDark),
              
              // Üstte "Sponsored" yazısı
              Positioned(
                top: 6,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Sponsored',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              
              // Sağ altta CTA butonu
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C6EF5),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4C6EF5).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Learn More',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdImage(bool isDark) {
    // Görsel yüklenmeye çalış, yoksa renkli placeholder göster
    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4C6EF5).withOpacity(0.8),
            const Color(0xFF845EF7).withOpacity(0.6),
            const Color(0xFFFFD43B).withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Arka planda görsel yükleme denemesi
          Positioned.fill(
            child: Image.asset(
              _selectedImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Görsel yoksa gradient göster (zaten arka planda var)
                return Container();
              },
            ),
          ),
          // Hafif overlay (fake olduğu belli olsun)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.08),
                ],
              ),
            ),
          ),
          // Orta kısımda dekoratif pattern (fake olduğu anlaşılsın)
          Center(
            child: Opacity(
              opacity: 0.25,
              child: Icon(
                Icons.ads_click,
                size: 40,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


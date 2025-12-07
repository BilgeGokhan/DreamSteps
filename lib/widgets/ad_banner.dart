import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';

/// Google AdMob banner reklam widget'ı
class AdBanner extends StatefulWidget {
  /// Banner yüksekliği. Default 110px.
  final double height;

  /// Border radius. Default 16px.
  final double borderRadius;

  const AdBanner({
    super.key,
    this.height = 110,
    this.borderRadius = 16,
  });

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // Platform'a göre ad unit ID seç
    final adUnitId = Platform.isIOS
        ? AdService.bannerAdUnitIdIOS
        : AdService.bannerAdUnitId;

    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('AdBanner: Failed to load ad: $error');
          ad.dispose();
          _bannerAd = null;
        },
        onAdOpened: (_) {
          debugPrint('AdBanner: Ad opened');
        },
        onAdClosed: (_) {
          debugPrint('AdBanner: Ad closed');
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      // Reklam yüklenene kadar placeholder göster
      return Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
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
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}




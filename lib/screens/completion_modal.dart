import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../state/dream_state.dart';

class CompletionModal extends StatelessWidget {
  const CompletionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DreamState>(
      builder: (context, dreamState, child) {
        final config = dreamState.currentCompletionConfig;

        // Random message selection
        String message = '';
        if (config != null) {
          final messages = [
            config.messageSoft,
            config.messageMotivational,
            config.messagePro,
          ].where((m) => m.isNotEmpty).toList();
          if (messages.isNotEmpty) {
            message = messages[Random().nextInt(messages.length)];
          }
        }

        // Parse color
        Color backgroundColor = const Color(0xFF845EF7);
        if (config != null && config.colorHex.isNotEmpty) {
          try {
            backgroundColor = Color(
              int.parse(config.colorHex.replaceFirst('#', '0xFF')),
            );
          } catch (e) {
            // Use default if parsing fails
          }
        }

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            // Lottie animation
                            Builder(
                              builder: (context) {
                                if (config != null &&
                                    config.animationFile.isNotEmpty) {
                                  // Animasyon dosyası yolunu düzelt
                                  final animationPath =
                                      config.animationFile.startsWith('assets/')
                                          ? config.animationFile
                                          : 'assets/animations/${config.animationFile}';
                                  
                                  // Try-catch ile animasyon yüklemeyi dene
                                  try {
                                    return SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: Lottie.asset(
                                        animationPath,
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) {
                                          // Animasyon yüklenemezse fallback göster
                                          return Container(
                                            width: 250,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.celebration,
                                              size: 120,
                                              color: Colors.white,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } catch (e) {
                                    // Hata durumunda fallback göster
                                    return Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.celebration,
                                        size: 120,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                } else {
                                  // Animasyon dosyası yoksa fallback göster
                                  return Container(
                                    width: 250,
                                    height: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.celebration,
                                      size: 120,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 40),
                            // Message
                            if (message.isNotEmpty)
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              )
                            else
                              Builder(
                                builder: (context) {
                                  final dreamState = Provider.of<DreamState>(context, listen: false);
                                  return Text(
                                    'Tebrikler! 🎉\n${dreamState.currentCycleNumber}. 30 günlük döngüyü tamamladın!',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      height: 1.4,
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 60),
                            // CTA Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Reset progress but keep dream and category
                                  dreamState.resetProgress();
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: backgroundColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text(
                                  config?.cta ?? 'Devam Et',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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


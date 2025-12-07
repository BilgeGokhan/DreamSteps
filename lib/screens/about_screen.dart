import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo? _packageInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageState>(
      builder: (context, languageState, child) {
        final localizations = AppLocalizations.of(context) ?? 
            AppLocalizations(languageState.locale);
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          appBar: AppBar(
            title: Text(
              localizations.aboutTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF111827)),
          ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<LanguageState>(
              builder: (context, languageState, child) {
                final localizations = AppLocalizations.of(context) ?? 
                    AppLocalizations(languageState.locale);
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // App Icon/Logo placeholder
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C6EF5).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            size: 50,
                            color: Color(0xFF4C6EF5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // App Name
                        const Text(
                          'DreamSteps',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Version Info
                        if (_packageInfo != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                  localizations.aboutVersion,
                                  _packageInfo!.version,
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  localizations.aboutBuildNumber,
                                  _packageInfo!.buildNumber,
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  localizations.aboutPackageName,
                                  _packageInfo!.packageName,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 32),
                        // Description
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.aboutDescriptionTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                localizations.aboutDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Copyright
                        Text(
                          '© ${DateTime.now().year} DreamSteps',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../state/dream_state.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';

class DreamInputScreen extends StatefulWidget {
  const DreamInputScreen({super.key});

  @override
  State<DreamInputScreen> createState() => _DreamInputScreenState();
}

class _DreamInputScreenState extends State<DreamInputScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Widget build edildikten sonra focus ver ve klavyeyi aç
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
        // Klavyeyi manuel olarak aç
        SystemChannels.textInput.invokeMethod('TextInput.show');
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _createSteps() async {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('tr'));
    final dreamText = _textController.text.trim();
    if (dreamText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.dreamInputError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final dreamState = Provider.of<DreamState>(context, listen: false);
    
    // Eğer henüz initialize edilmemişse, bekle
    if (!dreamState.isInitialized) {
      try {
        await dreamState.initialize();
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(localizations.dreamInputErrorGeneral(e.toString())),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }
    
    await dreamState.setDream(dreamText);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context, listen: false);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        final modalLocalizations = AppLocalizations.of(modalContext) ?? AppLocalizations(const Locale('tr'));
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                modalLocalizations.languageSelectionTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                modalLocalizations.languageSelectionSubtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              _buildLanguageOption(
                modalContext,
                modalLocalizations.languageTurkish,
                const Locale('tr'),
                '🇹🇷',
                languageState.locale.languageCode == 'tr',
              ),
              const SizedBox(height: 12),
              _buildLanguageOption(
                modalContext,
                modalLocalizations.languageEnglish,
                const Locale('en'),
                '🇬🇧',
                languageState.locale.languageCode == 'en',
              ),
              const SizedBox(height: 12),
              _buildLanguageOption(
                modalContext,
                modalLocalizations.languageGerman,
                const Locale('de'),
                '🇩🇪',
                languageState.locale.languageCode == 'de',
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String name,
    Locale locale,
    String flag,
    bool isSelected,
  ) {
    final languageState = Provider.of<LanguageState>(context, listen: false);
    
    return InkWell(
      onTap: () {
        languageState.setLanguage(locale);
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4C6EF5).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4C6EF5)
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: const Color(0xFF111827),
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4C6EF5),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('tr'));
    
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Color(0xFF111827)),
            onPressed: () => _showLanguageSelector(context),
            tooltip: localizations.languageSelectionTitle,
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Boş alana tıklanınca klavyeyi kapat
            _focusNode.unfocus();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              const SizedBox(height: 40),
              Text(
                localizations.dreamInputTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                localizations.dreamInputSubtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF111827).withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  // TextField container'ına tıklanınca focus ver ve klavyeyi aç
                  _focusNode.requestFocus();
                  SystemChannels.textInput.invokeMethod('TextInput.show');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    maxLines: 6,
                    minLines: 1,
                    enabled: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: localizations.dreamInputHint,
                      hintStyle: TextStyle(
                        color: const Color(0xFF111827).withOpacity(0.4),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: const Color(0xFF4C6EF5),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF111827),
                    ),
                    onTap: () {
                      // TextField'a tıklanınca focus ver ve klavyeyi aç
                      _focusNode.requestFocus();
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _createSteps,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C6EF5),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        localizations.dreamInputButton,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


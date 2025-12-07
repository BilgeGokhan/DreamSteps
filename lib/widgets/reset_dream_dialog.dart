import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';

/// Confirmation dialog for resetting dream
/// Shows a warning message and asks user to confirm before resetting
class ResetDreamDialog extends StatelessWidget {
  const ResetDreamDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context, listen: false);
    final localizations = AppLocalizations.of(context) ?? 
        AppLocalizations(languageState.locale);
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFFFA94D),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              localizations.resetDreamTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.resetDreamMessage,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF111827),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            localizations.resetDreamWarning,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF868E96),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.resetDreamItem1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF868E96),
                  ),
                ),
                Text(
                  localizations.resetDreamItem2,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF868E96),
                  ),
                ),
                Text(
                  localizations.resetDreamItem3,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF868E96),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            localizations.resetDreamFooter,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF111827),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            localizations.resetDreamCancel,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF868E96),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6B6B),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            localizations.resetDreamConfirm,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// Show the dialog and return true if user confirmed, false otherwise
  static Future<bool> show(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const ResetDreamDialog(),
    );
    return result ?? false;
  }
}


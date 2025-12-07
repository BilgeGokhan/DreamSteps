import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/dream_state.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';
import 'task_detail_screen.dart';

class AllStepsScreen extends StatelessWidget {
  const AllStepsScreen({super.key});

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
              localizations.allStepsTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF111827)),
          ),
      body: Consumer2<DreamState, LanguageState>(
        builder: (context, dreamState, languageState, child) {
          final localizations = AppLocalizations.of(context) ?? 
              AppLocalizations(languageState.locale);
          
          if (dreamState.dreamText == null || dreamState.dreamText!.isEmpty) {
            return Center(
              child: Text(
                localizations.allStepsNoDream,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF868E96),
                ),
              ),
            );
          }

          final currentCategory = dreamState.currentCategory;
          final primaryColor = currentCategory?.primaryColorValue ??
              const Color(0xFF4C6EF5);

          // Sadece tamamlanan günleri al ve sırala
          final completedDays = dreamState.completedTasks.toList()..sort();

          if (completedDays.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: primaryColor.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    localizations.allStepsNoCompleted,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.allStepsNoCompletedSubtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: completedDays.length,
              itemBuilder: (context, index) {
                final dayNumber = completedDays[index];
                final task = dreamState.getTaskForDay(dayNumber);
                
                if (task == null) {
                  return const SizedBox.shrink();
                }

                final isToday = dayNumber == dreamState.currentDay - 1;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isToday
                            ? primaryColor.withOpacity(0.2)
                            : primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '$dayNumber',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    title: Builder(
                      builder: (context) {
                        final languageState = Provider.of<LanguageState>(context, listen: false);
                        final localizations = AppLocalizations.of(context) ?? 
                            AppLocalizations(languageState.locale);
                        return Text(
                          '${localizations.allStepsDay} $dayNumber',
                          style: TextStyle(
                            fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                            color: const Color(0xFF111827),
                            fontSize: 16,
                          ),
                        );
                      },
                    ),
                    subtitle: Builder(
                      builder: (context) {
                        final languageState = Provider.of<LanguageState>(context, listen: false);
                        final languageCode = languageState.locale.languageCode;
                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            task.getTitle(languageCode),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                        );
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: const Color(0xFF51CF66),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: primaryColor.withOpacity(0.6),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TaskDetailScreen(
                            task: task,
                            category: currentCategory,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
        );
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../state/dream_state.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';
import 'completion_modal.dart';
import 'task_detail_screen.dart';
import '../widgets/ad_banner.dart';
import '../widgets/reset_dream_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkCompletion();
    });
  }

  void _checkCompletion() {
    final dreamState = Provider.of<DreamState>(context, listen: false);
    // Her 30 günde bir completion modal göster
    if (dreamState.isCycleFinished) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const CompletionModal(),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DreamState>(
      builder: (context, dreamState, child) {
        // Redirect if no dream
        if (dreamState.dreamText == null || dreamState.dreamText!.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/dream_input');
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Kategoriye göre renkleri al
        final currentCategory = dreamState.currentCategory;
        final backgroundColor =
            currentCategory?.backgroundColorValue ?? const Color(0xFFF6F7FB);
        final primaryColor =
            currentCategory?.primaryColorValue ?? const Color(0xFF4C6EF5);
        final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('tr'));

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: primaryColor,
                  size: 24,
                ),
                tooltip: localizations.dashboardChangeDream,
                onPressed: () => _showResetDialog(context, dreamState),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Dream title with category icon
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 14),
                          child: Column(
                            children: [
                              // Category icon
                              if (currentCategory != null)
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: currentCategory.getIconWidget(
                                      size: 32,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              if (currentCategory != null)
                                const SizedBox(height: 10),
                              Text(
                                dreamState.dreamText!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF111827),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Daily task card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localizations.dashboardTodayTask,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Builder(
                                  builder: (context) {
                                    final todayTask = dreamState.todayTask;
                                    if (todayTask == null) {
                                      return Text(
                                        localizations.dreamInputLoading,
                                        style: const TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF111827),
                                          height: 1.35,
                                        ),
                                      );
                                    }
                                    final languageState = Provider.of<LanguageState>(context, listen: false);
                                    final languageCode = languageState.locale.languageCode;
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TaskDetailScreen(
                                              task: todayTask,
                                              category: currentCategory,
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                todayTask.getTitle(languageCode),
                                                style: const TextStyle(
                                                  fontSize: 15.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF111827),
                                                  height: 1.4,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                              color:
                                                  primaryColor.withOpacity(0.6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 14),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: dreamState.todayTask == null ||
                                            dreamState.todayTask!.title.isEmpty
                                        ? null
                                        : (kDebugMode ||
                                                !dreamState.isTodayCompleted)
                                            ? () {
                                                final success = dreamState
                                                    .completeTodayTask();
                                                if (success) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          localizations.dashboardTaskCompleted),
                                                      backgroundColor:
                                                          const Color(0xFF51CF66),
                                                      duration:
                                                          const Duration(seconds: 2),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          localizations.dashboardTaskAlreadyCompleted),
                                                      backgroundColor:
                                                          Colors.orange,
                                                      duration:
                                                          const Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          localizations.dashboardMarkCompleted,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Progress bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${dreamState.currentCycleNumber}. ${localizations.dashboardCycleDay} ${dreamState.dayInCurrentCycle} / 30',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    Text(
                                      '${dreamState.progressPercentage.toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: dreamState.progressPercentage / 100,
                                    minHeight: 9,
                                    backgroundColor: const Color(0xFFF6F7FB),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                // Bottom area - Sabit altta
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mini motivational message - Butonların üstünde
                      Builder(
                        builder: (context) {
                          final languageState = Provider.of<LanguageState>(context, listen: false);
                          final languageCode = languageState.locale.languageCode;
                          final motivationalMessage = dreamState.getTodayMotivationalMessage(languageCode);
                          if (motivationalMessage == null) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    primaryColor.withOpacity(0.15),
                                    primaryColor.withOpacity(0.2),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color:
                                        _getMotivationalIconColor(primaryColor),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      motivationalMessage,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        color: _getMotivationalTextColor(
                                            primaryColor),
                                        height: 1.3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/statistics');
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryColor,
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                localizations.dashboardStatistics,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/all_steps');
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryColor,
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                localizations.dashboardAllSteps,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Google AdMob Banner
                      const AdBanner(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Show reset dream confirmation dialog
  Future<void> _showResetDialog(
      BuildContext context, DreamState dreamState) async {
    final confirmed = await ResetDreamDialog.show(context);

    if (confirmed && mounted) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Reset dream
      await dreamState.resetDream();

      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Navigate to dream input screen
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/dream_input');
      }
    }
  }


  /// Get appropriate icon color for motivational message based on category
  /// For light colors (like car_home's gray), use a darker, more visible color
  Color _getMotivationalIconColor(Color primaryColor) {
    // Calculate brightness of primary color
    final brightness = primaryColor.computeLuminance();

    // If color is too light (like car_home's gray #ADB5BD), use a darker variant
    if (brightness > 0.6) {
      // For light colors, use a darker shade or the primary color with higher opacity
      return primaryColor.withOpacity(0.8);
    }

    return primaryColor;
  }

  /// Get appropriate text color for motivational message based on category
  /// For light colors, use darker text for better readability
  Color _getMotivationalTextColor(Color primaryColor) {
    // Calculate brightness of primary color
    final brightness = primaryColor.computeLuminance();

    // If color is too light (like car_home's gray #ADB5BD), use darker text
    if (brightness > 0.6) {
      // Use a darker gray for better contrast
      return const Color(0xFF495057); // Dark gray for readability
    }

    // For normal colors, use standard dark text
    return const Color(0xFF111827);
  }
}

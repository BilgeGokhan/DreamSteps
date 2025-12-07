import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/dream_state.dart';
import '../state/language_state.dart';
import '../l10n/app_localizations.dart';
import '../widgets/reset_dream_dialog.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  /// Show reset dream confirmation dialog
  Future<void> _showResetDialog(BuildContext context) async {
    final dreamState = Provider.of<DreamState>(context, listen: false);
    final confirmed = await ResetDreamDialog.show(context);
    
    if (confirmed) {
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
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Navigate to dream input screen
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/dream_input');
      }
    }
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
              localizations.statisticsTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF111827)),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: Color(0xFF111827),
                  size: 24,
                ),
                tooltip: localizations.statisticsAbout,
                onPressed: () {
                  Navigator.of(context).pushNamed('/about');
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: Color(0xFF111827),
                  size: 24,
                ),
                tooltip: localizations.dashboardChangeDream,
                onPressed: () => _showResetDialog(context),
              ),
            ],
          ),
      body: Consumer2<DreamState, LanguageState>(
        builder: (context, dreamState, languageState, child) {
          final localizations = AppLocalizations.of(context) ?? 
              AppLocalizations(languageState.locale);
          
          if (dreamState.dreamText == null || dreamState.dreamText!.isEmpty) {
            return Center(
              child: Text(
                localizations.statisticsNoDream,
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

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                // Dream title
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (currentCategory != null)
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: currentCategory.getIconWidget(
                              size: 26,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      if (currentCategory != null) const SizedBox(height: 10),
                      Text(
                        dreamState.dreamText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Streak Card
                _buildStatCard(
                  context: context,
                  title: '🔥 ${localizations.statisticsStreak}',
                  value: '${dreamState.currentStreak}',
                  subtitle: localizations.statisticsDay,
                  icon: Icons.local_fire_department,
                  color: primaryColor,
                ),
                const SizedBox(height: 12),

                // Total Completed Days
                _buildStatCard(
                  context: context,
                  title: '✅ ${localizations.statisticsTotalCompleted}',
                  value: '${dreamState.totalCompletedDays}',
                  subtitle: localizations.statisticsDay,
                  icon: Icons.check_circle,
                  color: const Color(0xFF51CF66),
                ),
                const SizedBox(height: 12),

                // Progress Card
                _buildProgressCard(
                  context: context,
                  dreamState: dreamState,
                  primaryColor: primaryColor,
                ),
                const SizedBox(height: 12),

                // Weekly Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context: context,
                        title: '📅 ${localizations.statisticsThisWeek}',
                        value: '${dreamState.thisWeekCompleted}',
                        subtitle: localizations.statisticsDay,
                        icon: Icons.calendar_today,
                        color: const Color(0xFF845EF7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context: context,
                        title: '📆 ${localizations.statisticsThisMonth}',
                        value: '${dreamState.thisMonthCompleted}',
                        subtitle: localizations.statisticsDay,
                        icon: Icons.calendar_month,
                        color: const Color(0xFF4C6EF5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Days Active
                _buildStatCard(
                  context: context,
                  title: '⏱️ ${localizations.statisticsTotalTime}',
                  value: '${dreamState.daysActive}',
                  subtitle: localizations.statisticsDaysActive,
                  icon: Icons.timer,
                  color: const Color(0xFFFFA94D),
                ),
                const SizedBox(height: 12),

                // Motivational message
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withOpacity(0.15),
                        primaryColor.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: _getMotivationalIconColor(primaryColor),
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              localizations.statisticsGreatJob,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getMotivationalTitleColor(primaryColor),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              dreamState.currentStreak > 0
                                  ? localizations.statisticsStreakMessage(dreamState.currentStreak)
                                  : localizations.statisticsFirstStep,
                              style: TextStyle(
                                fontSize: 12,
                                color: _getMotivationalTextColor(primaryColor),
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF868E96),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: color,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: color.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard({
    required BuildContext context,
    required DreamState dreamState,
    required Color primaryColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: primaryColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Builder(
                  builder: (context) {
                    final languageState = Provider.of<LanguageState>(context, listen: false);
                    final localizations = AppLocalizations.of(context) ?? 
                        AppLocalizations(languageState.locale);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📊 ${localizations.statisticsProgress}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF868E96),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Flexible(
                              child: Text(
                                '${dreamState.currentCycleNumber}. ${localizations.statisticsCycle} ${dreamState.dayInCurrentCycle}/30',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  height: 1.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${dreamState.progressPercentage.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: dreamState.progressPercentage / 100,
              minHeight: 8,
              backgroundColor: const Color(0xFFF6F7FB),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
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

  /// Get appropriate title color for motivational message based on category
  Color _getMotivationalTitleColor(Color primaryColor) {
    // Calculate brightness of primary color
    final brightness = primaryColor.computeLuminance();
    
    // If color is too light (like car_home's gray #ADB5BD), use darker text
    if (brightness > 0.6) {
      // Use a darker gray for better contrast
      return const Color(0xFF495057); // Dark gray for readability
    }
    
    // For normal colors, use primary color
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


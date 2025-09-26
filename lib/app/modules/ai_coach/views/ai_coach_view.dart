import 'package:fit_pulse/app/core/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';

class AiCoachView extends StatelessWidget {
  const AiCoachView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'AI Coach',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.psychology,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AI Coach Card
                      GlassmorphicContainer(
                        // No height constraint - let content determine size
                        padding: const EdgeInsets.all(16.0),
                        borderRadius: 20,
                        blur: 25.0,
                        opacity: 0.15,
                        shadowColor: AppTheme.neonPurple,
                        shadowBlurRadius: 20,
                        shadowOffset: const Offset(0, 8),
                        borderWidth: 1.5,
                        borderColor: Colors.white.withOpacity(0.3),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.neonPurple.withOpacity(0.25),
                            AppTheme.neonPurple.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.neonPink,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.smart_toy,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'FitPulse AI',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Your personal fitness assistant',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '👋 Hi there! I\'m here to help you achieve your fitness goals. Based on your recent activity, I have some personalized recommendations for you.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Today's Recommendations
                      const Text(
                        'Today\'s Recommendations',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildRecommendationCard(
                        title: 'Hydration Reminder',
                        subtitle: 'You\'re 2 glasses behind your daily goal',
                        action: 'Drink Water',
                        icon: Icons.water_drop,
                        color: AppTheme.neonCyan,
                      ),

                      const SizedBox(height: 12),

                      _buildRecommendationCard(
                        title: 'Quick Cardio Session',
                        subtitle: 'Perfect time for a 15-minute HIIT workout',
                        action: 'Start Workout',
                        icon: Icons.directions_run,
                        color: AppTheme.neonPink,
                      ),

                      const SizedBox(height: 12),

                      _buildRecommendationCard(
                        title: 'Stretching Break',
                        subtitle: 'You\'ve been active! Time to stretch',
                        action: 'Start Stretching',
                        icon: Icons.self_improvement,
                        color: AppTheme.neonYellow,
                      ),

                      const SizedBox(height: 32),

                      // Quick Actions
                      const Text(
                        'Ask Your AI Coach',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        height: 340,
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.0,
                          children: [
                            _buildQuickActionCard(
                              title: 'Workout Plan',
                              subtitle: 'Get personalized plan',
                              icon: Icons.fitness_center,
                              color: AppTheme.neonPink,
                            ),
                            _buildQuickActionCard(
                              title: 'Nutrition Tips',
                              subtitle: 'Meal suggestions',
                              icon: Icons.restaurant,
                              color: AppTheme.neonYellow,
                            ),
                            _buildQuickActionCard(
                              title: 'Progress ',
                              subtitle: 'Review your stats',
                              icon: Icons.analytics,
                              color: AppTheme.neonCyan,
                            ),
                            _buildQuickActionCard(
                              title: 'Recovery Tips',
                              subtitle: 'Rest day guidance',
                              icon: Icons.spa,
                              color: AppTheme.neonGreen,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Chat with AI
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Text(
                                  'Ask me anything about fitness...',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.neonPink,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required String title,
    required String subtitle,
    required String action,
    required IconData icon,
    required Color color,
  }) {
    return GlassmorphicContainer(
      // No height constraint - let content determine size
      padding: const EdgeInsets.all(16.0),
      borderRadius: 20,
      blur: 25.0,
      opacity: 0.15,
      shadowColor: color,
      shadowBlurRadius: 20,
      shadowOffset: const Offset(0, 8),
      borderWidth: 1.5,
      borderColor: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.25),
          color.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              action,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle quick action tap
      },
      child: GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: color,
        shadowBlurRadius: 20,
        shadowOffset: const Offset(0, 8),
        borderWidth: 1.5,
        borderColor: Colors.white.withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.25),
            color.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

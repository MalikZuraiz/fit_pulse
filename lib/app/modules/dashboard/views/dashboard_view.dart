import 'dart:ui';
import 'package:fit_pulse/app/core/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

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
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Text(
                              controller.userName.value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: controller.navigateToNotifications,
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: controller.navigateToSettings,
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Main Content - Tab Views
              Expanded(child: Obx(() => _buildTabContent())),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildTabContent() {
    switch (controller.currentIndex.value) {
      case 0:
        return _buildHomeContent();
      case 1:
        return _buildWorkoutsContent();
      case 2:
        return _buildTrackerContent();
      case 3:
        return _buildAiCoachContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Card
          _buildProfileCard(),
          const SizedBox(height: 24),

          // Stats Grid
          SizedBox(
            height: 350,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(
                  title: 'Steps',
                  value: '7,500',
                  target: '10,000',
                  progress: 0.75,
                  icon: Icons.directions_walk,
                  color: AppTheme.neonPink,
                ),
                _buildStatCard(
                  title: 'Calories',
                  value: '1,850',
                  target: '2,200',
                  progress: 0.84,
                  icon: Icons.local_fire_department,
                  color: AppTheme.neonYellow,
                ),
                _buildStatCard(
                  title: 'Sleep',
                  value: '7h 30m',
                  target: '8h',
                  progress: 0.94,
                  icon: Icons.bedtime,
                  color: AppTheme.neonCyan,
                ),
                _buildStatCard(
                  title: 'Water',
                  value: '1.8L',
                  target: '2.5L',
                  progress: 0.72,
                  icon: Icons.water_drop,
                  color: AppTheme.neonBlue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: 'Start Workout',
                    subtitle: 'Quick 15 min session',
                    icon: Icons.play_arrow,
                    onTap: controller.navigateToWorkouts,
                    color: AppTheme.neonPink,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    title: 'Track Progress',
                    subtitle: 'View your stats',
                    icon: Icons.trending_up,
                    onTap: controller.navigateToProgress,
                    color: AppTheme.neonYellow,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Recent Achievement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Achievement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: controller.navigateToAchievements,
                child: Text(
                  'View All',
                  style: TextStyle(color: AppTheme.neonPink, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAchievementCard(),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildWorkoutsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header with quick start button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Workouts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Quick Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Today's Featured Workout
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.neonPink.withOpacity(0.3),
                  AppTheme.neonBlue.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.neonPink.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.star,
                        color: AppTheme.neonYellow,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Today\'s Featured',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Full Body HIIT Circuit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildWorkoutInfo(Icons.timer, '25 min'),
                    const SizedBox(width: 16),
                    _buildWorkoutInfo(Icons.local_fire_department, '320 cal'),
                    const SizedBox(width: 16),
                    _buildWorkoutInfo(Icons.fitness_center, 'Advanced'),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed('/workout-detail'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start Workout',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Categories Header
          const Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Categories Grid
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildWorkoutCategoryGridCard(
                title: 'Strength',
                subtitle: '12 exercises',
                icon: Icons.fitness_center,
                color: AppTheme.neonPink,
                onTap: () => Get.toNamed('/workout-categories'),
              ),
              _buildWorkoutCategoryGridCard(
                title: 'Cardio',
                subtitle: '8 exercises',
                icon: Icons.directions_run,
                color: AppTheme.neonBlue,
                onTap: () => Get.toNamed('/workout-categories'),
              ),
              _buildWorkoutCategoryGridCard(
                title: 'Yoga',
                subtitle: '15 exercises',
                icon: Icons.self_improvement,
                color: AppTheme.neonCyan,
                onTap: () => Get.toNamed('/workout-categories'),
              ),
              _buildWorkoutCategoryGridCard(
                title: 'HIIT',
                subtitle: '6 exercises',
                icon: Icons.flash_on,
                color: AppTheme.neonYellow,
                onTap: () => Get.toNamed('/workout-categories'),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Workouts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Workouts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(color: AppTheme.neonPink, fontSize: 14),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildRecentWorkoutCard(
            title: 'Upper Body Strength',
            date: 'Yesterday',
            duration: '45 min',
            calories: '280 cal',
            color: AppTheme.neonPink,
          ),

          const SizedBox(height: 12),

          _buildRecentWorkoutCard(
            title: 'Morning Yoga Flow',
            date: '2 days ago',
            duration: '30 min',
            calories: '150 cal',
            color: AppTheme.neonCyan,
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildTrackerContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header with date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Daily Summary Card
          GlassmorphicContainer(
            // No height constraint - let content determine size
            padding: const EdgeInsets.all(16.0),
            borderRadius: 20,
            blur: 25.0,
            opacity: 0.15,
            shadowColor: AppTheme.neonCyan,
            shadowBlurRadius: 20,
            shadowOffset: const Offset(0, 8),
            borderWidth: 1.5,
            borderColor: Colors.white.withOpacity(0.3),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.neonCyan.withOpacity(0.25),
                AppTheme.neonBlue.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.neonCyan.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.today,
                        color: AppTheme.neonCyan,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Today\'s Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressStat('72%', 'Overall'),
                    _buildProgressStat('8,432', 'Steps'),
                    _buildProgressStat('2.1L', 'Water'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  'Add Water',
                  Icons.water_drop,
                  AppTheme.neonBlue,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  'Log Meal',
                  Icons.restaurant,
                  AppTheme.neonYellow,
                  () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  'Add Sleep',
                  Icons.bedtime,
                  AppTheme.neonCyan,
                  () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Tracking Categories
          const Text(
            'Health Metrics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _buildDetailedTrackerCard(
            title: 'Water Intake',
            value: '1.8L',
            target: '2.5L',
            progress: 0.72,
            icon: Icons.water_drop,
            color: AppTheme.neonBlue,
            subtitle: '3 more glasses to go',
          ),

          const SizedBox(height: 16),

          _buildDetailedTrackerCard(
            title: 'Sleep Quality',
            value: '7h 30m',
            target: '8h',
            progress: 0.94,
            icon: Icons.bedtime,
            color: AppTheme.neonCyan,
            subtitle: 'Good quality, almost there!',
          ),

          const SizedBox(height: 16),

          _buildDetailedTrackerCard(
            title: 'Daily Steps',
            value: '8,432',
            target: '10,000',
            progress: 0.84,
            icon: Icons.directions_walk,
            color: AppTheme.neonPink,
            subtitle: '1,568 steps remaining',
          ),

          const SizedBox(height: 16),

          _buildDetailedTrackerCard(
            title: 'Calories Burned',
            value: '1,850',
            target: '2,200',
            progress: 0.84,
            icon: Icons.local_fire_department,
            color: AppTheme.neonYellow,
            subtitle: '350 calories to go',
          ),

          const SizedBox(height: 24),

          // Weekly Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Summary',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeeklyStat('5', 'Workouts'),
                    _buildWeeklyStat('52h', 'Sleep'),
                    _buildWeeklyStat('14.2L', 'Water'),
                    _buildWeeklyStat('12,450', 'Avg Steps'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildAiCoachContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Header with status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI Coach',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GlassmorphicContainer(
                // No height constraint - let content determine size
                padding: const EdgeInsets.all(16.0),
                borderRadius: 20,
                blur: 25.0,
                opacity: 0.15,
                shadowColor: AppTheme.neonPink,
                shadowBlurRadius: 20,
                shadowOffset: const Offset(0, 8),
                borderWidth: 1.5,
                borderColor: Colors.white.withOpacity(0.3),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.neonPink.withOpacity(0.25),
                    AppTheme.neonPink.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.neonPink,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Online',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Today's Recommendation Card
          GlassmorphicContainer(
            // No height constraint - let content determine size
            padding: const EdgeInsets.all(16.0),
            borderRadius: 20,
            blur: 25.0,
            opacity: 0.15,
            shadowColor: AppTheme.neonPink,
            shadowBlurRadius: 20,
            shadowOffset: const Offset(0, 8),
            borderWidth: 1.5,
            borderColor: Colors.white.withOpacity(0.3),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.neonPink.withOpacity(0.25),
                AppTheme.neonYellow.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.neonPink.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.psychology,
                        color: AppTheme.neonPink,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Today\'s Personalized Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Based on your sleep quality (94%) and recent cardio performance, I recommend:',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildRecommendationItem(
                  '💪',
                  'Upper body strength training (30 min)',
                  AppTheme.neonPink,
                ),
                const SizedBox(height: 8),
                _buildRecommendationItem(
                  '🧘',
                  'Cool-down yoga stretches (10 min)',
                  AppTheme.neonCyan,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed('/workout-detail'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Start Plan'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.toNamed('/ai-coach'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Customize'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // AI Insights Section
          const Text(
            'AI Insights',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          _buildInsightCard(
            icon: Icons.trending_up,
            title: 'Performance Trend',
            content:
                'Your cardio endurance improved by 12% this week! Keep it up.',
            color: AppTheme.neonBlue,
            trend: '+12%',
          ),

          const SizedBox(height: 16),

          _buildInsightCard(
            icon: Icons.favorite,
            title: 'Recovery Status',
            content:
                'Your heart rate variability suggests good recovery. Perfect time for strength training.',
            color: AppTheme.neonPink,
            trend: 'Good',
          ),

          const SizedBox(height: 16),

          _buildInsightCard(
            icon: Icons.psychology_alt,
            title: 'Motivation Level',
            content:
                'You\'ve been consistent for 5 days straight! Your dedication is paying off.',
            color: AppTheme.neonYellow,
            trend: '🔥 5 days',
          ),

          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'Quick Ask AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildQuickAskChip('Meal suggestions', Icons.restaurant),
              _buildQuickAskChip('Exercise form tips', Icons.fitness_center),
              _buildQuickAskChip('Recovery advice', Icons.spa),
              _buildQuickAskChip('Motivation boost', Icons.emoji_events),
            ],
          ),

          const SizedBox(height: 24),

          // Chat Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed('/ai-coach'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.neonPink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text(
                'Start Conversation with AI Coach',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String target,
    required double progress,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.6), color.withOpacity(0.3)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                  shadows: [
                    Shadow(
                      color: color.withOpacity(0.8),
                      offset: const Offset(0, 0),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              shadows: [
                Shadow(
                  color: color.withOpacity(0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
                const Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Text(
            'of $target',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: color.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color.withOpacity(0.3), width: 0.5),
                ),
                child: Text(
                  progress >= 1.0 ? 'Complete!' : 'In Progress',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard() {
    return GlassmorphicContainer(
      // No height constraint - let content determine size
      padding: const EdgeInsets.all(16.0),
      borderRadius: 20,
      blur: 25.0,
      opacity: 0.15,
      shadowColor: AppTheme.neonYellow,
      shadowBlurRadius: 20,
      shadowOffset: const Offset(0, 8),
      borderWidth: 1.5,
      borderColor: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.neonYellow.withOpacity(0.25),
          AppTheme.neonYellow.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.neonYellow.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.emoji_events,
              color: AppTheme.neonYellow,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'First Week Complete!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You completed 7 workouts this week',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '+100 XP',
            style: TextStyle(
              color: AppTheme.neonYellow,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: controller.bottomNavItems.asMap().entries.map((entry) {
          int index = entry.key;
          BottomNavItem item = entry.value;

          return Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => controller.changeTabIndex(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    gradient: controller.currentIndex.value == index
                        ? AppTheme.primaryGradient
                        : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: controller.currentIndex.value == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        size: 20,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: controller.currentIndex.value == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper methods for workout content
  Widget _buildWorkoutInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildWorkoutCategoryGridCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWorkoutCard({
    required String title,
    required String date,
    required String duration,
    required String calories,
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.fitness_center, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  date,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                calories,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper methods for tracker content
  Widget _buildProgressStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
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
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedTrackerCard({
    required String title,
    required String value,
    required String target,
    required double progress,
    required IconData icon,
    required Color color,
    required String subtitle,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
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
                    const SizedBox(height: 2),
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
              Text(
                '$value / $target',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Helper methods for AI Coach content
  Widget _buildRecommendationItem(String emoji, String text, Color color) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
    required String trend,
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  content,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              trend,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAskChip(String text, IconData icon) {
    return GestureDetector(
      onTap: () => Get.toNamed('/ai-coach'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white.withOpacity(0.8), size: 14),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return GestureDetector(
      onTap: controller.navigateToProfile,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 200,
        borderRadius: 20,
        blur: 20,
        opacity: 0.15,
        borderWidth: 2,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderColor: AppTheme.neonGreen.withOpacity(0.4),
        shadowColor: AppTheme.neonGreen.withOpacity(0.1),
        shadowBlurRadius: 15,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Animated Avatar with Glow
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.neonPink.withOpacity(0.3),
                      AppTheme.neonBlue.withOpacity(0.3),
                      AppTheme.neonCyan.withOpacity(0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.neonPink.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: AppTheme.neonBlue.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/default_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.transparent,
                          AppTheme.neonPink.withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.userName.value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.neonYellow.withOpacity(0.3),
                                    AppTheme.neonPink.withOpacity(0.3),
                                  ],
                                ),
                              ),
                              child: Text(
                                'Level 15',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Fitness Enthusiast',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

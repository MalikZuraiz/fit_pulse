import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../../../core/widgets/advanced_animations.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header
              _buildHeader(),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AnimatedCard(
                        delay: const Duration(milliseconds: 100),
                        child: _buildProfileHeader(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedCard(
                        delay: const Duration(milliseconds: 200),
                        child: _buildStatsGrid(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedCard(
                        delay: const Duration(milliseconds: 300),
                        child: _buildAchievements(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedCard(
                        delay: const Duration(milliseconds: 400),
                        child: _buildPersonalInfo(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedCard(
                        delay: const Duration(milliseconds: 500),
                        child: _buildGoals(),
                      ),
                      const SizedBox(height: 20),
                      AnimatedCard(
                        delay: const Duration(milliseconds: 600),
                        child: _buildPreferences(),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          FadeInLeft(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const Spacer(),
          FadeInRight(
            delay: const Duration(milliseconds: 400),
            child: PulseAnimation(
              duration: const Duration(seconds: 2),
              child: GestureDetector(
                onTap: () => controller.editProfile(),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.neonPink.withOpacity(0.6),
                        AppTheme.neonBlue.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      blur: 25,
      opacity: 0.15,
      shadowColor: AppTheme.neonPink,
      shadowBlurRadius: 20,
      shadowOffset: const Offset(0, 10),
      borderWidth: 1.5,
      borderColor: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.neonPink.withOpacity(0.2),
          AppTheme.neonBlue.withOpacity(0.15),
          AppTheme.neonCyan.withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
      ),
      child: Column(
        children: [
          // Profile Image
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonPink.withOpacity(0.6),
                      AppTheme.neonBlue.withOpacity(0.6),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Obx(() => ClipOval(
                  child: controller.profileImage.value.isNotEmpty
                      ? Image.network(
                          controller.profileImage.value,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 50,
                        ),
                )),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => controller.changeProfileImage(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.neonCyan.withOpacity(0.8),
                          AppTheme.neonBlue.withOpacity(0.8),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name and Level
          Obx(() => Column(
            children: [
              Text(
                controller.userName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonYellow.withOpacity(0.6),
                      AppTheme.neonPink.withOpacity(0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Level ${controller.userLevel.value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
          const SizedBox(height: 16),
          // Level Progress
          Obx(() => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Level ${controller.userLevel.value + 1}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${controller.levelProgress.value}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: controller.levelProgress.value / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.neonPink,
                          AppTheme.neonCyan,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Obx(() => GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(
          'Workouts',
          controller.totalWorkouts.value.toString(),
          Icons.fitness_center,
          AppTheme.neonPink,
        ),
        _buildStatCard(
          'Streak',
          '${controller.currentStreak.value} days',
          Icons.local_fire_department,
          AppTheme.neonYellow,
        ),
        _buildStatCard(
          'Calories',
          '${controller.totalCalories.value}k',
          Icons.local_fire_department,
          AppTheme.neonCyan,
        ),
        _buildStatCard(
          'Hours',
          '${controller.totalHours.value}h',
          Icons.schedule,
          AppTheme.neonBlue,
        ),
      ],
    ));
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      blur: 20,
      opacity: 0.15,
      shadowColor: color,
      shadowBlurRadius: 15,
      shadowOffset: const Offset(0, 6),
      borderWidth: 1,
      borderColor: Colors.white.withOpacity(0.2),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.6),
                  color.withOpacity(0.3),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      blur: 25,
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
          AppTheme.neonYellow.withOpacity(0.15),
          AppTheme.neonPink.withOpacity(0.1),
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
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonYellow.withOpacity(0.6),
                      AppTheme.neonYellow.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Recent Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => Column(
            children: controller.recentAchievements
                .map((achievement) => _buildAchievementItem(achievement))
                .toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.neonPink.withOpacity(0.6),
                  AppTheme.neonBlue.withOpacity(0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  achievement['description'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            achievement['date'] as String,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      blur: 25,
      opacity: 0.15,
      shadowColor: AppTheme.neonBlue,
      shadowBlurRadius: 20,
      shadowOffset: const Offset(0, 8),
      borderWidth: 1.5,
      borderColor: Colors.white.withOpacity(0.3),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.neonBlue.withOpacity(0.15),
          AppTheme.neonCyan.withOpacity(0.1),
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
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonBlue.withOpacity(0.6),
                      AppTheme.neonBlue.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Personal Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => Column(
            children: [
              _buildInfoRow('Age', '${controller.userAge.value} years'),
              _buildInfoRow('Height', '${controller.userHeight.value} cm'),
              _buildInfoRow('Weight', '${controller.userWeight.value} kg'),
              _buildInfoRow('Activity Level', controller.activityLevel.value),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildGoals() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      blur: 25,
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
          AppTheme.neonCyan.withOpacity(0.15),
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
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonCyan.withOpacity(0.6),
                      AppTheme.neonCyan.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.flag_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Fitness Goals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => Column(
            children: [
              _buildGoalItem('Weight Goal', '${controller.weightGoal.value} kg', 0.7),
              _buildGoalItem('Weekly Workouts', '${controller.weeklyWorkoutGoal.value} times', 0.6),
              _buildGoalItem('Daily Calories', '${controller.dailyCalorieGoal.value} kcal', 0.8),
              _buildGoalItem('Daily Steps', '${controller.dailyStepsGoal.value}', 0.9),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildPreferences() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      blur: 25,
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
          AppTheme.neonPink.withOpacity(0.15),
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
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonPink.withOpacity(0.6),
                      AppTheme.neonPink.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildActionButton('Edit Profile', Icons.edit, () => controller.editProfile()),
              _buildActionButton('Change Password', Icons.lock, () => controller.changePassword()),
              _buildActionButton('Export Data', Icons.download, () => controller.exportData()),
              _buildActionButton('Privacy Settings', Icons.privacy_tip, () => controller.openPrivacySettings()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem(String title, String value, double progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonCyan,
                      AppTheme.neonYellow,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.white70,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
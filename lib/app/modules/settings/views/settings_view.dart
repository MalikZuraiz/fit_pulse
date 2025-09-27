import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

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
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: _buildNotificationSettings(),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: _buildAppPreferences(),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: _buildUnitsDisplay(),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _buildPrivacySettings(),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 500),
                        child: _buildDataManagement(),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        child: _buildAboutSection(),
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
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildToggleItem(
            'Workout Reminders',
            'Get reminded about your scheduled workouts',
            Icons.fitness_center,
            controller.workoutReminders,
            () => controller.toggleNotification('workout'),
          ),
          _buildToggleItem(
            'Meal Reminders',
            'Never miss your meal tracking',
            Icons.restaurant,
            controller.mealReminders,
            () => controller.toggleNotification('meal'),
          ),
          _buildToggleItem(
            'Water Reminders',
            'Stay hydrated throughout the day',
            Icons.water_drop,
            controller.waterReminders,
            () => controller.toggleNotification('water'),
          ),
          _buildToggleItem(
            'Sleep Reminders',
            'Maintain healthy sleep schedule',
            Icons.bedtime,
            controller.sleepReminders,
            () => controller.toggleNotification('sleep'),
          ),
          _buildToggleItem(
            'Progress Updates',
            'Weekly and monthly progress reports',
            Icons.trending_up,
            controller.progressUpdates,
            () => controller.toggleNotification('progress'),
          ),
          _buildToggleItem(
            'Achievement Notifications',
            'Celebrate your milestones',
            Icons.emoji_events,
            controller.achievementNotifications,
            () => controller.toggleNotification('achievement'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
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
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'App Preferences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildToggleItem(
            'Dark Mode',
            'Use dark theme throughout the app',
            Icons.dark_mode,
            controller.darkMode,
            () => controller.toggleAppPreference('darkMode'),
          ),
          _buildToggleItem(
            'Biometric Authentication',
            'Use fingerprint or face ID',
            Icons.fingerprint,
            controller.biometricAuth,
            () => controller.toggleAppPreference('biometric'),
          ),
          _buildToggleItem(
            'Auto Sync',
            'Automatically sync data to cloud',
            Icons.sync,
            controller.autoSync,
            () => controller.toggleAppPreference('autoSync'),
          ),
          _buildToggleItem(
            'Vibration',
            'Enable haptic feedback',
            Icons.vibration,
            controller.vibration,
            () => controller.toggleAppPreference('vibration'),
          ),
          _buildToggleItem(
            'Sound',
            'Enable notification sounds',
            Icons.volume_up,
            controller.sound,
            () => controller.toggleAppPreference('sound'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitsDisplay() {
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
                  Icons.straighten,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Units & Display',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDropdownItem(
            'Weight Unit',
            'Choose your preferred weight unit',
            Icons.fitness_center,
            controller.selectedWeightUnit,
            controller.weightUnits,
            controller.changeWeightUnit,
          ),
          _buildDropdownItem(
            'Distance Unit',
            'Choose your preferred distance unit',
            Icons.straighten,
            controller.selectedDistanceUnit,
            controller.distanceUnits,
            controller.changeDistanceUnit,
          ),
          _buildDropdownItem(
            'Language',
            'Select app language',
            Icons.language,
            controller.selectedLanguage,
            controller.languages,
            controller.changeLanguage,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
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
                  Icons.privacy_tip_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Privacy & Security',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildToggleItem(
            'Data Sharing',
            'Share anonymized data for improvements',
            Icons.share,
            controller.dataSharing,
            () => controller.togglePrivacy('dataSharing'),
          ),
          _buildToggleItem(
            'Analytics',
            'Help improve the app with usage analytics',
            Icons.analytics,
            controller.analytics,
            () => controller.togglePrivacy('analytics'),
          ),
          _buildToggleItem(
            'Personalization',
            'Allow personalized recommendations',
            Icons.person,
            controller.personalization,
            () => controller.togglePrivacy('personalization'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDataManagement() {
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
                  Icons.storage,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Data Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionItem(
            'Export Data',
            'Download your data as JSON file',
            Icons.download,
            controller.exportData,
          ),
          _buildActionItem(
            'Clear Cache',
            'Free up storage space',
            Icons.cleaning_services,
            controller.clearCache,
          ),
          _buildActionItem(
            'Reset Settings',
            'Reset all settings to default',
            Icons.restore,
            controller.resetSettings,
            isLast: true,
            isDangerous: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
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
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoItem('Version', '1.0.0'),
          _buildInfoItem('Build', '1001'),
          _buildInfoItem('Developer', 'FitPulse Team'),
          _buildInfoItem('Contact', 'support@fitpulse.com', isLast: true),
        ],
      ),
    );
  }

  Widget _buildToggleItem(
    String title,
    String subtitle,
    IconData icon,
    RxBool value,
    VoidCallback onTap, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 50,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: value.value 
                        ? AppTheme.neonPink 
                        : Colors.white.withOpacity(0.3),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: value.value 
                        ? Alignment.centerRight 
                        : Alignment.centerLeft,
                    child: Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
        if (!isLast) 
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 40),
            color: Colors.white.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _buildDropdownItem(
    String title,
    String subtitle,
    IconData icon,
    RxString selectedValue,
    List<String> options,
    Function(String) onChanged, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: DropdownButton<String>(
                  value: selectedValue.value,
                  underline: const SizedBox(),
                  dropdownColor: Colors.grey.shade900,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 16),
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onChanged(newValue);
                    }
                  },
                ),
              )),
            ],
          ),
        ),
        if (!isLast) 
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 40),
            color: Colors.white.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _buildActionItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isLast = false,
    bool isDangerous = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDangerous 
                        ? Colors.red.withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isDangerous ? Colors.red : Colors.white70,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isDangerous ? Colors.red : Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        if (!isLast) 
          Container(
            height: 1,
            margin: const EdgeInsets.only(left: 40),
            color: Colors.white.withOpacity(0.1),
          ),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value, {bool isLast = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
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
        ),
        if (!isLast) 
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),
      ],
    );
  }
}
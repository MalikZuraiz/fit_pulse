import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // User Profile Data
  final userName = 'Alex Johnson'.obs;
  final profileImage = ''.obs;
  final userLevel = 12.obs;
  final levelProgress = 75.obs;
  
  // Personal Information
  final userAge = 28.obs;
  final userHeight = 175.obs;
  final userWeight = 75.obs;
  final activityLevel = 'Moderately Active'.obs;
  
  // Stats
  final totalWorkouts = 147.obs;
  final currentStreak = 7.obs;
  final totalCalories = 2.4.obs; // in thousands
  final totalHours = 89.obs;
  
  // Goals
  final weightGoal = 70.obs;
  final weeklyWorkoutGoal = 5.obs;
  final dailyCalorieGoal = 2200.obs;
  final dailyStepsGoal = '10,000'.obs;
  
  // Achievements
  final recentAchievements = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAchievements();
  }

  void _initializeAchievements() {
    recentAchievements.value = [
      {
        'title': '7-Day Streak',
        'description': 'Completed workouts for 7 consecutive days',
        'icon': Icons.local_fire_department,
        'date': '2 days ago',
      },
      {
        'title': 'Early Bird',
        'description': 'Completed 5 morning workouts this week',
        'icon': Icons.wb_sunny,
        'date': '1 week ago',
      },
      {
        'title': 'Strength Master',
        'description': 'Lifted over 10,000 lbs this month',
        'icon': Icons.fitness_center,
        'date': '2 weeks ago',
      },
      {
        'title': 'Consistency King',
        'description': 'Worked out 20 days this month',
        'icon': Icons.emoji_events,
        'date': '3 weeks ago',
      },
    ];
  }

  void editProfile() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              controller: TextEditingController(text: userName.value),
              onChanged: (value) => userName.value = value,
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: userAge.value.toString()),
              onChanged: (value) => userAge.value = int.tryParse(value) ?? userAge.value,
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: userHeight.value.toString()),
              onChanged: (value) => userHeight.value = int.tryParse(value) ?? userHeight.value,
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: userWeight.value.toString()),
              onChanged: (value) => userWeight.value = int.tryParse(value) ?? userWeight.value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Profile Updated',
                'Your profile has been successfully updated.',
                backgroundColor: Colors.green.withOpacity(0.8),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Save', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void changeProfileImage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption('Camera', Icons.camera_alt, () {
                  Get.back();
                  Get.snackbar(
                    'Camera',
                    'Opening camera...',
                    backgroundColor: Colors.blue.withOpacity(0.8),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }),
                _buildImageOption('Gallery', Icons.photo_library, () {
                  Get.back();
                  Get.snackbar(
                    'Gallery',
                    'Opening gallery...',
                    backgroundColor: Colors.green.withOpacity(0.8),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }),
                _buildImageOption('Remove', Icons.delete, () {
                  profileImage.value = '';
                  Get.back();
                  Get.snackbar(
                    'Removed',
                    'Profile picture removed.',
                    backgroundColor: Colors.red.withOpacity(0.8),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildImageOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void changePassword() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Password Changed',
                'Your password has been successfully changed.',
                backgroundColor: Colors.green.withOpacity(0.8),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Change', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void exportData() {
    Get.snackbar(
      'Exporting Data',
      'Your data is being prepared for download...',
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
    
    // Simulate export process
    Future.delayed(const Duration(seconds: 2), () {
      Get.snackbar(
        'Export Complete',
        'Your data has been exported successfully.',
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  void openPrivacySettings() {
    Get.toNamed('/settings');
  }

  void updateGoal(String goalType, dynamic value) {
    switch (goalType) {
      case 'weight':
        weightGoal.value = value;
        break;
      case 'workouts':
        weeklyWorkoutGoal.value = value;
        break;
      case 'calories':
        dailyCalorieGoal.value = value;
        break;
      case 'steps':
        dailyStepsGoal.value = value.toString();
        break;
    }
    
    Get.snackbar(
      'Goal Updated',
      'Your fitness goal has been updated successfully.',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addAchievement(String title, String description, IconData icon) {
    recentAchievements.insert(0, {
      'title': title,
      'description': description,
      'icon': icon,
      'date': 'Just now',
    });
    
    // Keep only the 5 most recent achievements
    if (recentAchievements.length > 5) {
      recentAchievements.removeLast();
    }
  }
}
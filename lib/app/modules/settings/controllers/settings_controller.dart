import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Notification settings
  var workoutReminders = true.obs;
  var mealReminders = true.obs;
  var waterReminders = true.obs;
  var sleepReminders = true.obs;
  var progressUpdates = true.obs;
  var achievementNotifications = true.obs;
  
  // App preferences
  var darkMode = false.obs;
  var biometricAuth = false.obs;
  var autoSync = true.obs;
  var vibration = true.obs;
  var sound = true.obs;
  
  // Units & Display
  var selectedWeightUnit = 'kg'.obs;
  var selectedDistanceUnit = 'km'.obs;
  var selectedLanguage = 'English'.obs;
  
  // Privacy
  var dataSharing = false.obs;
  var analytics = true.obs;
  var personalization = true.obs;
  
  final weightUnits = ['kg', 'lbs'];
  final distanceUnits = ['km', 'miles'];
  final languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];
  
  void toggleNotification(String type) {
    switch (type) {
      case 'workout':
        workoutReminders.value = !workoutReminders.value;
        break;
      case 'meal':
        mealReminders.value = !mealReminders.value;
        break;
      case 'water':
        waterReminders.value = !waterReminders.value;
        break;
      case 'sleep':
        sleepReminders.value = !sleepReminders.value;
        break;
      case 'progress':
        progressUpdates.value = !progressUpdates.value;
        break;
      case 'achievement':
        achievementNotifications.value = !achievementNotifications.value;
        break;
    }
  }
  
  void toggleAppPreference(String type) {
    switch (type) {
      case 'darkMode':
        darkMode.value = !darkMode.value;
        break;
      case 'biometric':
        biometricAuth.value = !biometricAuth.value;
        break;
      case 'autoSync':
        autoSync.value = !autoSync.value;
        break;
      case 'vibration':
        vibration.value = !vibration.value;
        break;
      case 'sound':
        sound.value = !sound.value;
        break;
    }
  }
  
  void togglePrivacy(String type) {
    switch (type) {
      case 'dataSharing':
        dataSharing.value = !dataSharing.value;
        break;
      case 'analytics':
        analytics.value = !analytics.value;
        break;
      case 'personalization':
        personalization.value = !personalization.value;
        break;
    }
  }
  
  void changeWeightUnit(String unit) {
    selectedWeightUnit.value = unit;
  }
  
  void changeDistanceUnit(String unit) {
    selectedDistanceUnit.value = unit;
  }
  
  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }
  
  void exportData() {
    Get.snackbar(
      'Export Data',
      'Your data has been exported successfully',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  void clearCache() {
    Get.snackbar(
      'Cache Cleared',
      'Application cache has been cleared',
      backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  void resetSettings() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text('Reset Settings', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to reset all settings to default?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Reset all settings to default
              workoutReminders.value = true;
              mealReminders.value = true;
              waterReminders.value = true;
              sleepReminders.value = true;
              progressUpdates.value = true;
              achievementNotifications.value = true;
              darkMode.value = false;
              biometricAuth.value = false;
              autoSync.value = true;
              vibration.value = true;
              sound.value = true;
              dataSharing.value = false;
              analytics.value = true;
              personalization.value = true;
              selectedWeightUnit.value = 'kg';
              selectedDistanceUnit.value = 'km';
              selectedLanguage.value = 'English';
              
              Get.back();
              Get.snackbar(
                'Settings Reset',
                'All settings have been reset to default',
                backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
                colorText: Colors.white,
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
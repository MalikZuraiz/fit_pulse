import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class DashboardController extends GetxController {
  final StorageService _storageService = Get.find();
  
  RxInt currentIndex = 0.obs;
  RxString userName = ''.obs;
  RxInt dailySteps = 0.obs;
  RxDouble dailyCalories = 0.0.obs;
  RxInt sleepHours = 0.obs;

  final List<BottomNavItem> bottomNavItems = [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.fitness_center, label: 'Workouts'),
    BottomNavItem(icon: Icons.track_changes, label: 'Tracker'),
    BottomNavItem(icon: Icons.psychology, label: 'AI Coach'),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _loadDailyStats();
  }

  void _loadUserData() {
    userName.value = _storageService.userName ?? 'Fitness Enthusiast';
  }

  void _loadDailyStats() {
    // Simulate daily stats - in real app this would come from API/sensors
    dailySteps.value = 7500;
    dailyCalories.value = 1850.5;
    sleepHours.value = 7;
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
    // No navigation - just change tab content within the same screen
  }

  void navigateToWorkouts() {
    Get.toNamed(AppRoutes.workoutCategories);
  }

  void navigateToProgress() {
    Get.toNamed(AppRoutes.progress);
  }

  void navigateToAchievements() {
    Get.toNamed(AppRoutes.achievements);
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  void navigateToNotifications() {
    Get.toNamed(AppRoutes.notifications);
  }

  void navigateToProfile() {
    Get.toNamed(AppRoutes.profile);
  }

  void logout() {
    _storageService.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({required this.icon, required this.label});
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';

class TrackerController extends GetxController {
  final StorageService _storageService = Get.find();
  
  // Observable values for daily tracking
  RxInt dailySteps = 0.obs;
  RxInt stepsGoal = 10000.obs;
  RxDouble caloriesBurned = 0.0.obs;
  RxDouble caloriesGoal = 2000.0.obs;
  RxInt waterIntake = 0.obs; // glasses of water
  RxInt waterGoal = 8.obs;
  RxInt sleepHours = 0.obs;
  RxInt sleepMinutes = 0.obs;
  RxInt sleepGoal = 8.obs; // hours
  RxDouble weight = 0.0.obs;
  RxString selectedDate = ''.obs;
  
  // Weekly data
  RxList<DailyStats> weeklyStats = <DailyStats>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadGoals();
    _loadTodayStats();
    _loadWeeklyStats();
    selectedDate.value = DateTime.now().toString().split(' ')[0];
  }
  
  void _loadGoals() {
    stepsGoal.value = _storageService.dailyStepsGoal;
    caloriesGoal.value = _storageService.dailyCaloriesGoal;
    sleepGoal.value = _storageService.dailySleepGoal;
  }
  
  void _loadTodayStats() {
    // Simulate loading today's stats - in real app this would come from health APIs
    dailySteps.value = 6750;
    caloriesBurned.value = 1450.5;
    waterIntake.value = 5;
    sleepHours.value = 7;
    sleepMinutes.value = 30;
    weight.value = 75.5;
  }
  
  void _loadWeeklyStats() {
    // Simulate weekly data
    weeklyStats.value = [
      DailyStats(date: DateTime.now().subtract(const Duration(days: 6)), steps: 8500, calories: 1800, sleep: 7.5),
      DailyStats(date: DateTime.now().subtract(const Duration(days: 5)), steps: 9200, calories: 1950, sleep: 8.0),
      DailyStats(date: DateTime.now().subtract(const Duration(days: 4)), steps: 7800, calories: 1650, sleep: 6.5),
      DailyStats(date: DateTime.now().subtract(const Duration(days: 3)), steps: 10500, calories: 2100, sleep: 8.5),
      DailyStats(date: DateTime.now().subtract(const Duration(days: 2)), steps: 9800, calories: 1900, sleep: 7.0),
      DailyStats(date: DateTime.now().subtract(const Duration(days: 1)), steps: 8900, calories: 1750, sleep: 7.5),
      DailyStats(date: DateTime.now(), steps: dailySteps.value, calories: caloriesBurned.value, sleep: sleepHours.value + (sleepMinutes.value / 60)),
    ];
  }
  
  void incrementWater() {
    if (waterIntake.value < waterGoal.value + 5) {
      waterIntake.value++;
      Get.snackbar(
        'Great!',
        'Keep staying hydrated! 💧',
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
  
  void decrementWater() {
    if (waterIntake.value > 0) {
      waterIntake.value--;
    }
  }
  
  void updateWeight(double newWeight) {
    weight.value = newWeight;
    Get.snackbar(
      'Weight Updated',
      'New weight: ${newWeight.toStringAsFixed(1)} kg',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  void updateSleep(int hours, int minutes) {
    sleepHours.value = hours;
    sleepMinutes.value = minutes;
    Get.snackbar(
      'Sleep Updated',
      'Sleep time: ${hours}h ${minutes}m',
      backgroundColor: Colors.purple.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  // Getters for progress percentages
  double get stepsProgress => (dailySteps.value / stepsGoal.value).clamp(0.0, 1.0);
  double get caloriesProgress => (caloriesBurned.value / caloriesGoal.value).clamp(0.0, 1.0);
  double get waterProgress => (waterIntake.value / waterGoal.value).clamp(0.0, 1.0);
  double get sleepProgress => ((sleepHours.value + sleepMinutes.value / 60) / sleepGoal.value).clamp(0.0, 1.0);
}

class DailyStats {
  final DateTime date;
  final int steps;
  final double calories;
  final double sleep;
  
  DailyStats({
    required this.date,
    required this.steps,
    required this.calories,
    required this.sleep,
  });
}
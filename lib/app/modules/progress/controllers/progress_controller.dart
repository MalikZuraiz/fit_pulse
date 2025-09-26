import 'package:get/get.dart';

class ProgressController extends GetxController {
  final selectedPeriod = 'week'.obs;
  
  // Mock data for demonstration
  final weeklyStats = {
    'workouts': 5,
    'calories': 1250,
    'weightLost': 0.5,
    'activeDays': 6,
  };
  
  final monthlyStats = {
    'workouts': 24,
    'calories': 4280,
    'weightLost': 2.3,
    'activeDays': 18,
  };
  
  final yearlyStats = {
    'workouts': 145,
    'calories': 28500,
    'weightLost': 8.2,
    'activeDays': 220,
  };
  
  Map<String, dynamic> get currentStats {
    switch (selectedPeriod.value) {
      case 'month':
        return monthlyStats;
      case 'year':
        return yearlyStats;
      default:
        return weeklyStats;
    }
  }
  
  @override
  void onInit() {
    super.onInit();
    // Initialize with default period
    selectedPeriod.value = 'week';
  }
}
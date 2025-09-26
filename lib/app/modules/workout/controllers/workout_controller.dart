import 'package:get/get.dart';

class WorkoutController extends GetxController {
  final RxString selectedCategory = ''.obs;
  final RxList<WorkoutCategory> categories = <WorkoutCategory>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadWorkoutCategories();
  }
  
  void _loadWorkoutCategories() {
    categories.value = [
      WorkoutCategory(
        name: 'Strength Training',
        description: 'Build muscle and strength',
        workoutCount: 45,
        icon: 'strength',
      ),
      WorkoutCategory(
        name: 'Cardio',
        description: 'Burn calories and improve endurance',
        workoutCount: 32,
        icon: 'cardio',
      ),
      WorkoutCategory(
        name: 'Yoga & Flexibility',
        description: 'Improve flexibility and mindfulness',
        workoutCount: 28,
        icon: 'yoga',
      ),
      WorkoutCategory(
        name: 'HIIT',
        description: 'High-intensity interval training',
        workoutCount: 25,
        icon: 'hiit',
      ),
      WorkoutCategory(
        name: 'Pilates',
        description: 'Core strength and stability',
        workoutCount: 20,
        icon: 'pilates',
      ),
      WorkoutCategory(
        name: 'Boxing',
        description: 'Combat training and conditioning',
        workoutCount: 18,
        icon: 'boxing',
      ),
    ];
  }
  
  void selectCategory(WorkoutCategory category) {
    selectedCategory.value = category.name;
    Get.toNamed('/workout-detail', arguments: {
      'category': category.name,
      'description': category.description,
      'workoutCount': category.workoutCount,
      'icon': category.icon,
    });
  }
}

class WorkoutCategory {
  final String name;
  final String description;
  final int workoutCount;
  final String icon;
  
  WorkoutCategory({
    required this.name,
    required this.description,
    required this.workoutCount,
    required this.icon,
  });
}
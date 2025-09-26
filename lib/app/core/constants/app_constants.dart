class AppConstants {
  // App Info
  static const String appName = 'FitPulse';
  static const String appVersion = '1.0.0';
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Sizes
  static const double borderRadius = 16.0;
  static const double cardElevation = 8.0;
  static const double buttonHeight = 56.0;
  
  // Padding & Margins
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  
  // Workout Categories
  static const List<String> workoutCategories = [
    'Strength Training',
    'Cardio',
    'Yoga & Flexibility',
    'HIIT',
    'Pilates',
    'Boxing',
    'Swimming',
    'Running',
  ];
  
  // Achievement Types
  static const List<String> achievementTypes = [
    'Steps Master',
    'Workout Warrior',
    'Consistency King',
    'Calorie Crusher',
    'Sleep Champion',
    'Hydration Hero',
  ];
}

class AppImages {
  static const String _basePath = 'assets/images/';
  
  // Onboarding
  static const String onboarding1 = '${_basePath}onboarding_1.png';
  static const String onboarding2 = '${_basePath}onboarding_2.png';
  static const String onboarding3 = '${_basePath}onboarding_3.png';
  
  // Workouts
  static const String strengthTraining = '${_basePath}strength_training.jpg';
  static const String cardio = '${_basePath}cardio.jpg';
  static const String yoga = '${_basePath}yoga.jpg';
  static const String hiit = '${_basePath}hiit.jpg';
  static const String pilates = '${_basePath}pilates.jpg';
  static const String boxing = '${_basePath}boxing.jpg';
  static const String swimming = '${_basePath}swimming.jpg';
  static const String running = '${_basePath}running.jpg';
  
  // Profile
  static const String defaultAvatar = '${_basePath}default_avatar.png';
}

class AppAnimations {
  static const String _basePath = 'assets/animations/';
  
  static const String loading = '${_basePath}loading.json';
  static const String success = '${_basePath}success.json';
  static const String workout = '${_basePath}workout.json';
  static const String meditation = '${_basePath}meditation.json';
  static const String celebration = '${_basePath}celebration.json';
}
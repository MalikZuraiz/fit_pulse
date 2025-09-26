import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/workout_controller.dart';

class WorkoutDetailView extends GetView<WorkoutController> {
  const WorkoutDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    final isQuickWorkout = arguments['quick'] == true;
    final category = arguments['category'] as String? ?? 'Selected Workout';
    final subtitle = arguments['subtitle'] as String? ?? '12 exercises';
    final color = arguments['color'] as Color? ?? AppTheme.neonPink;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Video Preview Section
              SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Video placeholder
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.3),
                              AppTheme.neonBlue.withOpacity(0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      ),
                      // Overlay gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Workout info overlay
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isQuickWorkout
                                  ? 'Quick Full Body Workout'
                                  : '$category Training',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _buildInfoChip(Icons.timer, '15 min'),
                                const SizedBox(width: 10),
                                _buildInfoChip(
                                  Icons.local_fire_department,
                                  '200 cal',
                                ),
                                const SizedBox(width: 10),
                                _buildInfoChip(
                                  Icons.fitness_center,
                                  subtitle.toLowerCase().contains('exercise')
                                      ? subtitle
                                      : 'Beginner',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      // Add to favorites
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Workout Description
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: GlassmorphicContainer(
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
                              const Text(
                                'About This Workout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'A complete full-body workout designed to burn calories and build strength. Perfect for beginners and suitable for home workouts with no equipment needed.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Exercise List
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Exercises',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...List.generate(
                              6,
                              (index) => _buildExerciseCard(index),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Start Workout Button
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        child: SizedBox(
                          width: double.infinity,
                          child: NeonGradientButton(
                            text: 'Start Workout',
                            onPressed: () {
                              _showWorkoutStartDialog();
                            },
                            gradient: AppTheme.primaryGradient,
                            height: 60,
                          ),
                        ),
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

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(int index) {
    final exercises = [
      {'name': 'Jumping Jacks', 'duration': '30 sec', 'rest': '10 sec'},
      {'name': 'Push-ups', 'duration': '45 sec', 'rest': '15 sec'},
      {'name': 'Squats', 'duration': '30 sec', 'rest': '10 sec'},
      {'name': 'Plank', 'duration': '60 sec', 'rest': '20 sec'},
      {'name': 'Mountain Climbers', 'duration': '30 sec', 'rest': '10 sec'},
      {'name': 'Burpees', 'duration': '45 sec', 'rest': '15 sec'},
    ];

    final exercise = exercises[index];

    return GlassmorphicContainer(
                          // No height constraint - let content determine size
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 16.0),
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
                              AppTheme.neonPink.withOpacity(0.25),
                              AppTheme.neonPink.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.3, 0.7, 1.0],
                          ),
                          child: Row(
                            children: [
                              // Exercise number
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          
                              const SizedBox(width: 16),
                          
                              // Exercise details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise['name']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          exercise['duration']!,
                                          style: TextStyle(
                                            color: AppTheme.neonGreen,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          ' • Rest ${exercise['rest']}',
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
                          
                              // Play button
                              GestureDetector(
                                onTap: () {
                                  // Preview exercise
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
    );
  }

  void _showWorkoutStartDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.darkCard,
        title: const Text(
          'Ready to Start?',
          style: TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Make sure you have enough space and water nearby. The workout will begin in 3 seconds after you press start.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.timer, color: AppTheme.neonGreen, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    '15 minutes',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: AppTheme.neonYellow,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '~200 calories',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 120,
                height: 40,
                child: NeonGradientButton(
                  text: 'Start Workout',
                  onPressed: () {
                    Get.back();
                    _startWorkoutSession();
                  },
                  gradient: AppTheme.primaryGradient,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startWorkoutSession() {
    // Show a simple snackbar for now instead of navigating to non-existent route
    Get.snackbar(
      'Workout Started!',
      'Great! Your workout session has begun. This feature is coming soon.',
      backgroundColor: AppTheme.neonGreen.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      snackPosition: SnackPosition.TOP,
    );
  }
}

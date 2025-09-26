import 'package:fit_pulse/app/core/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../routes/app_routes.dart';
import '../controllers/workout_controller.dart';

class WorkoutCategoriesView extends GetView<WorkoutController> {
  const WorkoutCategoriesView({super.key});

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
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Workout Categories',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quick Stats
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                title: 'Total Workouts',
                                value: '24',
                                icon: Icons.fitness_center,
                                color: AppTheme.neonPink,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildStatCard(
                                title: 'This Week',
                                value: '5',
                                icon: Icons.calendar_today,
                                color: AppTheme.neonYellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Categories Grid
                      const Text(
                        'Choose Your Workout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 400,
                        child: GridView.count(
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                          children: [
                            _buildCategoryCard(
                              title: 'Strength',
                              subtitle: '12 exercises',
                              icon: Icons.fitness_center,
                              color: AppTheme.neonPink,
                            ),
                            _buildCategoryCard(
                              title: 'Cardio',
                              subtitle: '8 exercises',
                              icon: Icons.directions_run,
                              color: AppTheme.neonCyan,
                            ),
                            _buildCategoryCard(
                              title: 'Yoga',
                              subtitle: '15 poses',
                              icon: Icons.self_improvement,
                              color: AppTheme.neonYellow,
                            ),
                            _buildCategoryCard(
                              title: 'HIIT',
                              subtitle: '6 circuits',
                              icon: Icons.timer,
                              color: AppTheme.neonBlue,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Recent Workouts
                      const Text(
                        'Recent Workouts',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildRecentWorkout(
                        title: 'Full Body Strength',
                        duration: '45 min',
                        calories: '320 cal',
                        date: 'Yesterday',
                      ),
                      const SizedBox(height: 12),
                      _buildRecentWorkout(
                        title: 'Morning Yoga Flow',
                        duration: '30 min',
                        calories: '180 cal',
                        date: '2 days ago',
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

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: color,
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
        child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to workout detail with category information
        Get.toNamed(AppRoutes.workoutDetail, arguments: {
          'category': title,
          'subtitle': subtitle,
          'color': color,
        });
      },
      child: GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: color,
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
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentWorkout({
    required String title,
    required String duration,
    required String calories,
    required String date,
  }) {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        borderRadius: 20,
        blur: 25.0,
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
            AppTheme.neonPink.withOpacity(0.25),
            AppTheme.neonPink.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child:  Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.neonPink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fitness_center,
              color: AppTheme.neonPink,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      duration,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      calories,
                      style: TextStyle(
                        color: AppTheme.neonPink,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
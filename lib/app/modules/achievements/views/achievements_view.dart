import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/achievements_controller.dart';

class AchievementsView extends GetView<AchievementsController> {
  AchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 150,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Achievements',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppTheme.backgroundGradient,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        FadeInDown(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              
              // Progress Overview
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeInUp(
                    child: _buildProgressOverview(),
                  ),
                ),
              ),
              
              // Recent Achievements
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInLeft(
                        child: Row(
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
                              'Recent Achievements',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(3, (index) => FadeInUp(
                        delay: Duration(milliseconds: 200 + (index * 100)),
                        child: _buildRecentAchievement(index),
                      )),
                    ],
                  ),
                ),
              ),
              
              // All Achievements
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 600),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                gradient: AppTheme.secondaryGradient,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'All Achievements',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _achievements.length,
                        itemBuilder: (context, index) {
                          return FadeInUp(
                            delay: Duration(milliseconds: 800 + (index * 100)),
                            child: _buildAchievementCard(_achievements[index]),
                          );
                        },
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

  Widget _buildProgressOverview() {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        borderRadius: 20,
        blur: 25.0,
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
             AppTheme.neonBlue.withOpacity(0.25),
             AppTheme.neonBlue.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Level 7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildStatItem('18', 'Unlocked', AppTheme.neonGreen),
                Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
                _buildStatItem('6', 'In Progress', AppTheme.neonYellow),
                Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
                _buildStatItem('12', 'Locked', Colors.grey),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Next Level Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '3,200 / 5,000 XP',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.64,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.neonPink),
                ),
              ],
            ),
          ],
        ),
    );
  }

  Widget _buildStatItem(String number, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAchievement(int index) {
    final recent = [
      {
        'title': '7-Day Streak',
        'description': 'Worked out for 7 consecutive days',
        'date': '2 days ago',
        'xp': 500,
        'icon': Icons.local_fire_department,
        'color': AppTheme.neonYellow,
      },
      {
        'title': 'Calorie Crusher',
        'description': 'Burned 1000+ calories in a single workout',
        'date': '5 days ago',
        'xp': 300,
        'icon': Icons.local_fire_department,
        'color': AppTheme.neonPink,
      },
      {
        'title': 'First Steps',
        'description': 'Completed your first workout',
        'date': '1 week ago',
        'xp': 100,
        'icon': Icons.directions_walk,
        'color': AppTheme.neonGreen,
      },
    ];

    final achievement = recent[index];
    
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        borderRadius: 20,
        blur: 25.0,
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
             AppTheme.neonBlue.withOpacity(0.25),
             AppTheme.neonBlue.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child:  Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [achievement['color'] as Color, (achievement['color'] as Color).withOpacity(0.6)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: (achievement['color'] as Color).withOpacity(0.5),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              achievement['icon'] as IconData,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['description'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['date'] as String,
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (achievement['color'] as Color).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '+${achievement['xp']} XP',
              style: TextStyle(
                color: achievement['color'] as Color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> achievement) {
    final bool isUnlocked = achievement['unlocked'] as bool;
    
    return GestureDetector(
      onTap: () => _showAchievementDetails(achievement),
      child: GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: achievement['color'] as Color,
        shadowBlurRadius: 20,
        shadowOffset: const Offset(0, 8),
        borderWidth: 1.5,
        borderColor: Colors.white.withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
             (achievement['color'] as Color).withOpacity(0.25),
             (achievement['color'] as Color).withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: isUnlocked 
                  ? LinearGradient(
                      colors: [achievement['color'] as Color, (achievement['color'] as Color).withOpacity(0.6)],
                    )
                  : LinearGradient(
                      colors: [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(0.1)],
                    ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                achievement['icon'] as IconData,
                color: isUnlocked ? Colors.white : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              achievement['title'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isUnlocked ? Colors.white : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            if (isUnlocked)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (achievement['color'] as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${achievement['xp']} XP',
                  style: TextStyle(
                    color: achievement['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LOCKED',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAchievementDetails(Map<String, dynamic> achievement) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.darkCard,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: (achievement['unlocked'] as bool)
                  ? LinearGradient(
                      colors: [achievement['color'] as Color, (achievement['color'] as Color).withOpacity(0.6)],
                    )
                  : LinearGradient(
                      colors: [Colors.grey.withOpacity(0.3), Colors.grey.withOpacity(0.1)],
                    ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                achievement['icon'] as IconData,
                color: (achievement['unlocked'] as bool) ? Colors.white : Colors.grey,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                achievement['title'] as String,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement['description'] as String,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            if (achievement['unlocked'] as bool) ...[
              Row(
                children: [
                  Icon(Icons.star, color: achievement['color'] as Color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Unlocked! +${achievement['xp']} XP',
                    style: TextStyle(
                      color: achievement['color'] as Color,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  const Icon(Icons.lock, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Locked - ${achievement['requirement']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close', style: TextStyle(color: AppTheme.neonPink)),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'First Steps',
      'description': 'Complete your first workout',
      'icon': Icons.directions_walk,
      'color': AppTheme.neonGreen,
      'xp': 100,
      'unlocked': true,
      'requirement': 'Complete 1 workout',
    },
    {
      'title': 'Week Warrior',
      'description': 'Complete 7 workouts',
      'icon': Icons.calendar_today,
      'color': AppTheme.neonBlue,
      'xp': 250,
      'unlocked': true,
      'requirement': 'Complete 7 workouts',
    },
    {
      'title': 'Calorie Crusher',
      'description': 'Burn 1000+ calories in one workout',
      'icon': Icons.local_fire_department,
      'color': AppTheme.neonYellow,
      'xp': 300,
      'unlocked': true,
      'requirement': 'Burn 1000+ calories',
    },
    {
      'title': 'Streak Master',
      'description': 'Maintain a 30-day workout streak',
      'icon': Icons.whatshot,
      'color': AppTheme.neonPink,
      'xp': 500,
      'unlocked': false,
      'requirement': '30-day streak',
    },
    {
      'title': 'Iron Will',
      'description': 'Complete 50 strength workouts',
      'icon': Icons.fitness_center,
      'color': AppTheme.neonPurple,
      'xp': 400,
      'unlocked': false,
      'requirement': '50 strength workouts',
    },
    {
      'title': 'Marathon Runner',
      'description': 'Run 42.2km in total',
      'icon': Icons.directions_run,
      'color': AppTheme.neonCyan,
      'xp': 600,
      'unlocked': false,
      'requirement': 'Run 42.2km total',
    },
  ];
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/progress_controller.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({super.key});

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
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Progress',
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
                  ),
                ),
                leading: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                actions: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    color: AppTheme.darkCard,
                    onSelected: (value) {
                      if (value == 'export') {
                        _showExportDialog();
                      } else if (value == 'settings') {
                        _showProgressSettings();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'export',
                        child: Row(
                          children: [
                            Icon(Icons.download, color: Colors.white),
                            SizedBox(width: 12),
                            Text('Export Data', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'settings',
                        child: Row(
                          children: [
                            Icon(Icons.settings, color: Colors.white),
                            SizedBox(width: 12),
                            Text('Settings', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              // Time Period Selector
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FadeInDown(
                    child: _buildTimePeriodSelector(),
                  ),
                ),
              ),
              
              // Stats Overview
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildStatsOverview(),
                  ),
                ),
              ),
              
              // Charts Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: _buildWeightChart(),
                      ),
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        child: _buildActivityChart(),
                      ),
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 800),
                        child: _buildCaloriesChart(),
                      ),
                      const SizedBox(height: 32),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1000),
                        child: _buildWorkoutFrequencyChart(),
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

  Widget _buildTimePeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildPeriodButton('Week', 'week'),
          _buildPeriodButton('Month', 'month'),
          _buildPeriodButton('Year', 'year'),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String label, String value) {
    return Obx(() => Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedPeriod.value = value,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: controller.selectedPeriod.value == value
                ? AppTheme.primaryGradient
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: controller.selectedPeriod.value == value
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildStatsOverview() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.0,
      children: [
        _buildStatCard(
          'Total Workouts',
          '24',
          Icons.fitness_center,
          AppTheme.neonGreen,
          '+12%',
        ),
        _buildStatCard(
          'Calories Burned',
          '4,280',
          Icons.local_fire_department,
          AppTheme.neonYellow,
          '+18%',
        ),
        _buildStatCard(
          'Weight Lost',
          '2.3 kg',
          Icons.monitor_weight,
          AppTheme.neonPink,
          '-5.2%',
        ),
        _buildStatCard(
          'Active Days',
          '18/30',
          Icons.calendar_today,
          AppTheme.neonCyan,
          '+25%',
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String change) {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: change.startsWith('+') ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      color: change.startsWith('+') ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
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

  Widget _buildWeightChart() {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
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
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Weight Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.monitor_weight,
                  color: AppTheme.neonPink,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}kg',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const weeks = ['W1', 'W2', 'W3', 'W4'];
                          return Text(
                            weeks[value.toInt() % weeks.length],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 75),
                        FlSpot(1, 74.5),
                        FlSpot(2, 73.8),
                        FlSpot(3, 72.7),
                      ],
                      isCurved: true,
                      gradient: LinearGradient(colors: [AppTheme.neonPink, AppTheme.neonPurple]),
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.neonPink.withOpacity(0.3),
                            AppTheme.neonPurple.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: AppTheme.neonPink,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    return  GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
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
        child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daily Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.directions_walk,
                  color: AppTheme.neonGreen,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 15000,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return Text(
                            days[value.toInt()],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(7, (index) {
                    final steps = [8500, 12000, 9800, 11500, 10200, 13000, 7800][index];
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: steps.toDouble(),
                          gradient: LinearGradient(
                            colors: [AppTheme.neonGreen, AppTheme.neonCyan],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: 20,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesChart() {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: AppTheme.neonYellow,
        shadowBlurRadius: 20,
        shadowOffset: const Offset(0, 8),
        borderWidth: 1.5,
        borderColor: Colors.white.withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
             AppTheme.neonYellow.withOpacity(0.25),
             AppTheme.neonYellow.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Calories Burned',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.local_fire_department,
                  color: AppTheme.neonYellow,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                      color: AppTheme.neonYellow,
                      value: 40,
                      title: 'Cardio\n40%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      color: AppTheme.neonPink,
                      value: 30,
                      title: 'Strength\n30%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      color: AppTheme.neonGreen,
                      value: 20,
                      title: 'Yoga\n20%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      color: AppTheme.neonCyan,
                      value: 10,
                      title: 'Other\n10%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutFrequencyChart() {
    return GlassmorphicContainer(
        // No height constraint - let content determine size
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        borderRadius: 20,
        blur: 25.0,
        opacity: 0.15,
        shadowColor: AppTheme.neonGreen,
        shadowBlurRadius: 20,
        shadowOffset: const Offset(0, 8),
        borderWidth: 1.5,
        borderColor: Colors.white.withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
             AppTheme.neonGreen.withOpacity(0.25),
             AppTheme.neonGreen.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Workout Frequency',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.fitness_center,
                  color: AppTheme.neonBlue,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(4, (index) {
                final workoutTypes = ['Cardio', 'Strength', 'Yoga', 'HIIT'];
                final frequencies = [8, 6, 4, 6];
                final colors = [AppTheme.neonYellow, AppTheme.neonPink, AppTheme.neonGreen, AppTheme.neonCyan];
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: colors[index],
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 80,
                        child: Text(
                          workoutTypes[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: frequencies[index] / 10,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [colors[index], colors[index].withOpacity(0.6)],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${frequencies[index]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.darkCard,
        title: const Text('Export Progress Data', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose the format for your progress data export:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: NeonGradientButton(
                    text: 'PDF',
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Export', 'PDF export coming soon!');
                    },
                    gradient: AppTheme.primaryGradient,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NeonGradientButton(
                    text: 'CSV',
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Export', 'CSV export coming soon!');
                    },
                    gradient: AppTheme.secondaryGradient,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }

  void _showProgressSettings() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.darkCard,
        title: const Text('Progress Settings', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Show Weight Progress', style: TextStyle(color: Colors.white)),
              value: true,
              onChanged: (value) {},
              activeColor: AppTheme.neonPink,
            ),
            SwitchListTile(
              title: const Text('Include Rest Days', style: TextStyle(color: Colors.white)),
              value: false,
              onChanged: (value) {},
              activeColor: AppTheme.neonPink,
            ),
            SwitchListTile(
              title: const Text('Weekly Summary', style: TextStyle(color: Colors.white)),
              value: true,
              onChanged: (value) {},
              activeColor: AppTheme.neonPink,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Done', style: TextStyle(color: AppTheme.neonPink)),
          ),
        ],
      ),
    );
  }
}
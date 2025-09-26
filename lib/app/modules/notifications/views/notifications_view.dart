import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

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
              // Custom Header
              _buildHeader(),
              // Filter Tabs
              _buildFilterTabs(),
              // Notification List
              Expanded(
                child: Obx(() => _buildNotificationList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Obx(() => controller.unreadCount.value > 0
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.neonPink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${controller.unreadCount.value}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => _buildTabButton(
              'All',
              controller.selectedFilter.value == 'all',
              () => controller.changeFilter('all'),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() => _buildTabButton(
              'Unread',
              controller.selectedFilter.value == 'unread',
              () => controller.changeFilter('unread'),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() => _buildTabButton(
              'Workout',
              controller.selectedFilter.value == 'workout',
              () => controller.changeFilter('workout'),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(() => _buildTabButton(
              'Meals',
              controller.selectedFilter.value == 'meals',
              () => controller.changeFilter('meals'),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppTheme.neonPink.withOpacity(0.6),
                    AppTheme.neonBlue.withOpacity(0.6),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    final filteredNotifications = controller.filteredNotifications;
    
    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildNotificationCard(notification),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              color: Colors.white.withOpacity(0.5),
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No notifications',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re all caught up!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] as bool;
    final type = notification['type'] as String;
    final title = notification['title'] as String;
    final message = notification['message'] as String;
    final time = notification['time'] as String;
    final priority = notification['priority'] as String;

    return GestureDetector(
      onTap: () => controller.markAsRead(notification['id']),
      child: GlassmorphicContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        blur: 20,
        opacity: isRead ? 0.1 : 0.15,
        shadowColor: _getTypeColor(type),
        shadowBlurRadius: isRead ? 10 : 15,
        shadowOffset: const Offset(0, 4),
        borderWidth: 1,
        borderColor: isRead 
            ? Colors.white.withOpacity(0.1)
            : _getTypeColor(type).withOpacity(0.3),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getTypeColor(type).withOpacity(isRead ? 0.05 : 0.15),
            Colors.white.withOpacity(0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getTypeColor(type).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTypeIcon(type),
                    color: _getTypeColor(type),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppTheme.neonPink,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                if (priority == 'high')
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'HIGH',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(
                color: Colors.white.withOpacity(isRead ? 0.6 : 0.8),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            if (notification['actionable'] == true) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _handleNotificationAction(notification, 'dismiss'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Dismiss',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _handleNotificationAction(notification, 'action'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getTypeColor(type).withOpacity(0.6),
                              _getTypeColor(type).withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getActionText(type),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'workout':
        return AppTheme.neonPink;
      case 'meal':
        return AppTheme.neonYellow;
      case 'water':
        return AppTheme.neonCyan;
      case 'sleep':
        return AppTheme.neonBlue;
      case 'achievement':
        return AppTheme.neonPink;
      case 'reminder':
        return AppTheme.neonCyan;
      default:
        return Colors.white;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'workout':
        return Icons.fitness_center;
      case 'meal':
        return Icons.restaurant;
      case 'water':
        return Icons.water_drop;
      case 'sleep':
        return Icons.bedtime;
      case 'achievement':
        return Icons.emoji_events;
      case 'reminder':
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  String _getActionText(String type) {
    switch (type) {
      case 'workout':
        return 'Start Workout';
      case 'meal':
        return 'Log Meal';
      case 'water':
        return 'Log Water';
      case 'sleep':
        return 'Log Sleep';
      case 'achievement':
        return 'View';
      case 'reminder':
        return 'Done';
      default:
        return 'View';
    }
  }

  void _handleNotificationAction(Map<String, dynamic> notification, String action) {
    if (action == 'dismiss') {
      controller.dismissNotification(notification['id']);
    } else {
      controller.handleNotificationAction(notification['id'], notification['type']);
    }
  }
}
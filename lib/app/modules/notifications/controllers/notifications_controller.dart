import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NotificationsController extends GetxController {
  // Observable properties
  final selectedFilter = 'all'.obs;
  final notifications = <Map<String, dynamic>>[].obs;
  final unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    // Sample notifications data
    notifications.value = [
      {
        'id': '1',
        'type': 'workout',
        'title': 'Workout Reminder',
        'message': 'Time for your evening workout! You have a chest and triceps session scheduled.',
        'time': '2 hours ago',
        'isRead': false,
        'priority': 'high',
        'actionable': true,
      },
      {
        'id': '2',
        'type': 'achievement',
        'title': 'New Achievement Unlocked!',
        'message': 'Congratulations! You\'ve completed 7 days workout streak. Keep it up!',
        'time': '5 hours ago',
        'isRead': false,
        'priority': 'normal',
        'actionable': false,
      },
      {
        'id': '3',
        'type': 'meal',
        'title': 'Meal Reminder',
        'message': 'Don\'t forget to log your lunch! Proper nutrition is key to your fitness goals.',
        'time': '1 day ago',
        'isRead': true,
        'priority': 'normal',
        'actionable': true,
      },
      {
        'id': '4',
        'type': 'water',
        'title': 'Hydration Check',
        'message': 'You\'re behind on your daily water intake. Drink a glass of water now!',
        'time': '1 day ago',
        'isRead': false,
        'priority': 'normal',
        'actionable': true,
      },
      {
        'id': '5',
        'type': 'sleep',
        'title': 'Sleep Reminder',
        'message': 'Time to wind down! Good sleep is essential for muscle recovery.',
        'time': '2 days ago',
        'isRead': true,
        'priority': 'normal',
        'actionable': false,
      },
      {
        'id': '6',
        'type': 'reminder',
        'title': 'Progress Update',
        'message': 'Your weekly progress report is ready. Check out your achievements!',
        'time': '3 days ago',
        'isRead': true,
        'priority': 'low',
        'actionable': true,
      },
    ];
    _updateUnreadCount();
  }

  void _updateUnreadCount() {
    unreadCount.value = notifications.where((n) => !(n['isRead'] as bool)).length;
  }

  List<Map<String, dynamic>> get filteredNotifications {
    switch (selectedFilter.value) {
      case 'unread':
        return notifications.where((n) => !(n['isRead'] as bool)).toList();
      case 'workout':
        return notifications.where((n) => n['type'] == 'workout').toList();
      case 'meals':
        return notifications.where((n) => n['type'] == 'meal').toList();
      default:
        return notifications.toList();
    }
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;
  }

  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
      _updateUnreadCount();
    }
  }

  void dismissNotification(String notificationId) {
    notifications.removeWhere((n) => n['id'] == notificationId);
    _updateUnreadCount();
    Get.snackbar(
      'Notification Dismissed',
      'The notification has been removed.',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void handleNotificationAction(String notificationId, String type) {
    markAsRead(notificationId);
    
    switch (type) {
      case 'workout':
        Get.snackbar(
          'Starting Workout',
          'Redirecting to workout tracker...',
          backgroundColor: Colors.blue.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        // Navigate to workout tracker
        Get.toNamed('/workout');
        break;
      case 'meal':
        Get.snackbar(
          'Log Meal',
          'Opening meal tracker...',
          backgroundColor: Colors.orange.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        // Navigate to meal tracker
        Get.toNamed('/meals');
        break;
      case 'water':
        Get.snackbar(
          'Water Logged',
          'Great! Keep staying hydrated.',
          backgroundColor: Colors.cyan.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        break;
      case 'sleep':
        Get.snackbar(
          'Sleep Mode',
          'Setting up sleep tracking...',
          backgroundColor: Colors.purple.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        break;
      case 'achievement':
        Get.snackbar(
          'Achievement',
          'Opening achievements page...',
          backgroundColor: Colors.yellow.withOpacity(0.8),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        break;
      default:
        Get.snackbar(
          'Action Completed',
          'The notification action has been processed.',
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
    _updateUnreadCount();
    
    Get.snackbar(
      'All Read',
      'All notifications marked as read.',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void clearAllNotifications() {
    notifications.clear();
    _updateUnreadCount();
    
    Get.snackbar(
      'Cleared',
      'All notifications have been cleared.',
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
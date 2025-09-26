import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final StorageService _storageService = Get.find();
  final PageController pageController = PageController();
  
  RxInt currentPage = 0.obs;
  
  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "Welcome to FitPulse",
      subtitle: "Your AI-powered fitness companion for a healthier lifestyle",
      icon: Icons.fitness_center,
    ),
    OnboardingData(
      title: "Track Your Progress",
      subtitle: "Monitor your daily activities, workouts, and health metrics",
      icon: Icons.trending_up,
    ),
    OnboardingData(
      title: "AI Coach Guidance",
      subtitle: "Get personalized recommendations and coaching from our AI",
      icon: Icons.psychology,
    ),
  ];

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    _storageService.isFirstTime = false;
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
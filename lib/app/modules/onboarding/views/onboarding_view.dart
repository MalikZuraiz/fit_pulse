import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

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
              // Skip button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: controller.skipOnboarding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Page content
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) => controller.currentPage.value = index,
                  itemCount: controller.onboardingPages.length,
                  itemBuilder: (context, index) {
                    final data = controller.onboardingPages[index];
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon with glow effect
                          FadeInDown(
                            delay: Duration(milliseconds: 200 * index),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppTheme.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.neonPink.withOpacity(0.3),
                                    blurRadius: 30,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                data.icon,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // Title
                          FadeInUp(
                            delay: Duration(milliseconds: 400 + 200 * index),
                            child: Text(
                              data.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Subtitle
                          FadeInUp(
                            delay: Duration(milliseconds: 600 + 200 * index),
                            child: Text(
                              data.subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.8),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Bottom section
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Page indicators
                    Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentPage.value == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: controller.currentPage.value == index
                                ? AppTheme.neonPink
                                : Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    )),
                    
                    const SizedBox(height: 40),
                    
                    // Navigation buttons
                    Row(
                      children: [
                        // Previous button
                        Obx(() => controller.currentPage.value > 0
                          ? Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: controller.previousPage,
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Center(
                                      child: Text(
                                        'Previous',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                        ),
                        
                        if (controller.currentPage.value > 0) const SizedBox(width: 16),
                        
                        // Next/Get Started button
                        Expanded(
                          child: Obx(() => NeonGradientButton(
                            text: controller.currentPage.value == controller.onboardingPages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            onPressed: controller.nextPage,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated background particles
            ...List.generate(50, (index) {
              return Positioned(
                left: (index % 10) * (Get.width / 10),
                top: (index ~/ 10) * (Get.height / 5),
                child: FadeInUp(
                  delay: Duration(milliseconds: index * 50),
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.neonPink.withOpacity(0.3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.neonPink.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with glow effect
                  FadeInDown(
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppTheme.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.neonPink.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // App name
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1000),
                    child: ShaderMask(
                      shaderCallback: (bounds) => AppTheme.primaryGradient
                          .createShader(bounds),
                      child: const Text(
                        'FitPulse',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Tagline
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      'AI Fitness & Wellness Tracker',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 80),
                  
                  // Loading indicator
                  FadeInUp(
                    delay: const Duration(milliseconds: 1500),
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.neonPink.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: const CircularProgressIndicator(
                        color: AppTheme.neonPink,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom text
            Positioned(
              bottom: 50,
              child: FadeInUp(
                delay: const Duration(milliseconds: 2000),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'Powered by AI',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
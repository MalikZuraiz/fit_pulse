import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/custom_widgets.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.signupFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  FadeInLeft(
                    child: IconButton(
                      onPressed: controller.goToLogin,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Header
                  FadeInDown(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.secondaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.neonCyan.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_add,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start your fitness journey today',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Name field
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildInputField(
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                      icon: Icons.person,
                      controller: controller.signupNameController,
                      validator: controller.nameValidator,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Email field
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _buildInputField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      icon: Icons.email,
                      controller: controller.signupEmailController,
                      validator: controller.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Password field
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GlassmorphicContainer(
                          height: 56,
                          child: Obx(() => TextFormField(
                            controller: controller.signupPasswordController,
                            obscureText: !controller.isPasswordVisible.value,
                            validator: controller.passwordValidator,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(Icons.lock, color: Colors.white54),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Confirm Password field
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GlassmorphicContainer(
                          height: 56,
                          child: Obx(() => TextFormField(
                            controller: controller.signupConfirmPasswordController,
                            obscureText: !controller.isConfirmPasswordVisible.value,
                            validator: controller.confirmPasswordValidator,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Confirm your password',
                              prefixIcon: const Icon(Icons.lock_outline, color: Colors.white54),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: controller.toggleConfirmPasswordVisibility,
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Terms and conditions
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(text: 'By creating an account, you agree to our '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AppTheme.neonCyan,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: AppTheme.neonCyan,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Signup button
                  FadeInUp(
                    delay: const Duration(milliseconds: 1200),
                    child: Obx(() => NeonGradientButton(
                      text: 'Create Account',
                      onPressed: controller.signup,
                      isLoading: controller.isSignupLoading.value,
                      gradient: AppTheme.secondaryGradient,
                    )),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Login link
                  FadeInUp(
                    delay: const Duration(milliseconds: 1400),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.goToLogin,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: AppTheme.neonCyan,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 8),
        GlassmorphicContainer(
          height: 56,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon, color: Colors.white54),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final StorageService _storageService = Get.find();
  
  // Login form
  final loginFormKey = GlobalKey<FormState>();
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  
  // Signup form
  final signupFormKey = GlobalKey<FormState>();
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  
  // Observable states
  RxBool isLoginLoading = false.obs;
  RxBool isSignupLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Login method
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    
    isLoginLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Save user data
      _storageService.isLoggedIn = true;
      _storageService.userEmail = loginEmailController.text;
      _storageService.userToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      
      Get.offAllNamed(AppRoutes.dashboard);
      Get.snackbar(
        'Success',
        'Welcome back!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoginLoading.value = false;
    }
  }

  // Signup method
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;
    
    isSignupLoading.value = true;
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Save user data
      _storageService.isLoggedIn = true;
      _storageService.userName = signupNameController.text;
      _storageService.userEmail = signupEmailController.text;
      _storageService.userToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      
      Get.offAllNamed(AppRoutes.dashboard);
      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Signup failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSignupLoading.value = false;
    }
  }

  // Navigate to signup
  void goToSignup() {
    Get.toNamed(AppRoutes.signup);
  }

  // Navigate to login
  void goToLogin() {
    Get.back();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != signupPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    super.onClose();
  }
}
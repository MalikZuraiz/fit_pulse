import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../routes/app_routes.dart';

class SplashController extends GetxController {
  late StorageService _storageService;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initializeAndNavigate();
  }

  void _initializeAndNavigate() async {
    try {
      // Wait for the splash animation
      await Future.delayed(const Duration(seconds: 2));
      
      // Get the storage service
      _storageService = Get.find<StorageService>();
      
      // Navigate based on user state
      if (_storageService.isFirstTime) {
        Get.offAllNamed(AppRoutes.onboarding);
      } else if (_storageService.isLoggedIn) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      // Fallback navigation to onboarding for new users
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
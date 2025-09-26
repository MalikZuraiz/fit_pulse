import 'package:get/get.dart';
import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // StorageService is already initialized in main.dart with Get.putAsync()
    // Just ensure it's accessible if needed
    if (!Get.isRegistered<StorageService>()) {
      Get.putAsync<StorageService>(() => StorageService.init(), permanent: true);
    }
  }
}
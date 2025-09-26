import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  
  late SharedPreferences _prefs;

  static Future<StorageService> init() async {
    final service = StorageService();
    service._prefs = await SharedPreferences.getInstance();
    return service;
  }

  // Generic read/write methods
  T? read<T>(String key) {
    switch (T) {
      case String:
        return _prefs.getString(key) as T?;
      case int:
        return _prefs.getInt(key) as T?;
      case double:
        return _prefs.getDouble(key) as T?;
      case bool:
        return _prefs.getBool(key) as T?;
      case const (List<String>):
        return _prefs.getStringList(key) as T?;
      default:
        return null;
    }
  }

  Future<bool> write<T>(String key, T value) async {
    switch (T) {
      case String:
        return await _prefs.setString(key, value as String);
      case int:
        return await _prefs.setInt(key, value as int);
      case double:
        return await _prefs.setDouble(key, value as double);
      case bool:
        return await _prefs.setBool(key, value as bool);
      case const (List<String>):
        return await _prefs.setStringList(key, value as List<String>);
      default:
        return false;
    }
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  bool hasKey(String key) {
    return _prefs.containsKey(key);
  }

  // App specific methods
  bool get isFirstTime => read<bool>('isFirstTime') ?? true;
  set isFirstTime(bool value) => write<bool>('isFirstTime', value);

  bool get isLoggedIn => read<bool>('isLoggedIn') ?? false;
  set isLoggedIn(bool value) => write<bool>('isLoggedIn', value);

  String? get userToken => read<String>('userToken');
  set userToken(String? value) => value != null ? write<String>('userToken', value) : remove('userToken');

  String? get userName => read<String>('userName');
  set userName(String? value) => value != null ? write<String>('userName', value) : remove('userName');

  String? get userEmail => read<String>('userEmail');
  set userEmail(String? value) => value != null ? write<String>('userEmail', value) : remove('userEmail');

  // Fitness data
  int get dailyStepsGoal => read<int>('dailyStepsGoal') ?? 10000;
  set dailyStepsGoal(int value) => write<int>('dailyStepsGoal', value);

  double get dailyCaloriesGoal => read<double>('dailyCaloriesGoal') ?? 2000.0;
  set dailyCaloriesGoal(double value) => write<double>('dailyCaloriesGoal', value);

  int get dailySleepGoal => read<int>('dailySleepGoal') ?? 8; // hours
  set dailySleepGoal(int value) => write<int>('dailySleepGoal', value);
}
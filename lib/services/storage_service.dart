import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

/// Service de stockage local - 100% hors ligne
class StorageService extends GetxService {
  late SharedPreferences _prefs;
  
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }
  
  // ==================== Activation ====================
  
  bool get isActivated => _prefs.getBool(AppConstants.keyIsActivated) ?? false;
  
  Future<void> setActivated(bool value) async {
    await _prefs.setBool(AppConstants.keyIsActivated, value);
  }
  
  String? get activationKey => _prefs.getString(AppConstants.keyActivationKey);
  
  Future<void> setActivationKey(String key) async {
    await _prefs.setString(AppConstants.keyActivationKey, key);
  }
  
  // ==================== Language ====================
  
  String get language => _prefs.getString(AppConstants.keyLanguage) ?? AppConstants.langFrench;
  
  Future<void> setLanguage(String lang) async {
    await _prefs.setString(AppConstants.keyLanguage, lang);
  }
  
  // ==================== Theme ====================
  
  String get themeMode => _prefs.getString(AppConstants.keyThemeMode) ?? 'light';
  
  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(AppConstants.keyThemeMode, mode);
  }
  
  // ==================== First Launch ====================
  
  bool get isFirstLaunch => _prefs.getBool(AppConstants.keyFirstLaunch) ?? true;
  
  Future<void> setFirstLaunch(bool value) async {
    await _prefs.setBool(AppConstants.keyFirstLaunch, value);
  }
  
  // ==================== Generic Methods ====================
  
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }
  
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }
  
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }
  
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }
  
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }
  
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }
  
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
  
  Future<void> clear() async {
    await _prefs.clear();
  }
  
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}

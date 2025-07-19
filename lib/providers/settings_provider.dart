import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TempUnit { celsius, fahrenheit }
enum DistanceUnit { kilometers, miles }

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  TempUnit _tempUnit = TempUnit.celsius;
  DistanceUnit _distanceUnit = DistanceUnit.kilometers;

  ThemeMode get themeMode => _themeMode;
  TempUnit get tempUnit => _tempUnit;
  DistanceUnit get distanceUnit => _distanceUnit;

  SettingsProvider() {
    _loadSettings();
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveSettings();
    notifyListeners();
  }

  void setTempUnit(TempUnit unit) {
    _tempUnit = unit;
    _saveSettings();
    notifyListeners();
  }

  void setDistanceUnit(DistanceUnit unit) {
    _distanceUnit = unit;
    _saveSettings();
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    _tempUnit = TempUnit.values[prefs.getInt('tempUnit') ?? 0];
    _distanceUnit = DistanceUnit.values[prefs.getInt('distanceUnit') ?? 0];
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', _themeMode.index);
    prefs.setInt('tempUnit', _tempUnit.index);
    prefs.setInt('distanceUnit', _distanceUnit.index);
  }
} 
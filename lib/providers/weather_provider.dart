import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../models/forecast.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  Weather? _weather;
  List<Forecast>? _forecast;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  List<Forecast>? get forecast => _forecast;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeatherByCity(String city) async {
    print('Fetching weather for city: ' + city); // Debug print
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _weather = await _weatherService.fetchWeatherByCity(city);
      _forecast = await _weatherService.fetchForecastByCity(city);
    } catch (e) {
      print('Weather API error: ' + e.toString()); // Debug print
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchWeatherByCoords(double lat, double lon) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _weather = await _weatherService.fetchWeatherByCoords(lat, lon);
      _forecast = await _weatherService.fetchForecastByCoords(lat, lon);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _weather = null;
    _forecast = null;
    _error = null;
    notifyListeners();
  }
} 
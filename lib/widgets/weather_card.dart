import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/settings_provider.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  String _formatTemp(BuildContext context, double temp) {
    final unit = Provider.of<SettingsProvider>(context, listen: false).tempUnit;
    if (unit == TempUnit.fahrenheit) {
      return ((temp * 9 / 5) + 32).toStringAsFixed(1) + '°F';
    }
    return temp.toStringAsFixed(1) + '°C';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: const Color(0xFFF7FAFC),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.cityName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF3A4D5C),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Image.network(
                'https://openweathermap.org/img/wn/${weather.iconCode}@4x.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTemp(context, weather.temperature),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5A7CA7),
              ),
            ),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF3A4D5C),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(Icons.thermostat, color: Color(0xFF5A7CA7)),
                    Text('Min: ${_formatTemp(context, weather.minTemp)}', style: const TextStyle(color: Color(0xFF3A4D5C))),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.thermostat_outlined, color: Color(0xFF5A7CA7)),
                    Text('Max: ${_formatTemp(context, weather.maxTemp)}', style: const TextStyle(color: Color(0xFF3A4D5C))),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.water_drop, color: Color(0xFF5A7CA7)),
                    Text('Humidity: ${weather.humidity}%', style: const TextStyle(color: Color(0xFF3A4D5C))),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.air, color: Color(0xFF5A7CA7)),
                    Text('Wind: ${weather.windSpeed} m/s', style: const TextStyle(color: Color(0xFF3A4D5C))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 
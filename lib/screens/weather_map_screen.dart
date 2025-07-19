import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WeatherMapScreen extends StatefulWidget {
  const WeatherMapScreen({Key? key}) : super(key: key);

  @override
  State<WeatherMapScreen> createState() => _WeatherMapScreenState();
}

class _WeatherMapScreenState extends State<WeatherMapScreen> {
  static const LatLng _initialPosition = LatLng(20.5937, 78.9629); // Center of India as default

  // TODO: Replace with your actual OpenWeatherMap API key
  static const String _owmApiKey = '87cff8c6d4cf00c5da369db2314de3cc';

  // List of weather overlay layers
  final List<Map<String, String>> _weatherLayers = [
    {
      'name': 'Clouds',
      'url': 'https://tile.openweathermap.org/map/clouds_new/{z}/{x}/{y}.png?appid=YOUR_OPENWEATHERMAP_API_KEY',
    },
    {
      'name': 'Precipitation',
      'url': 'https://tile.openweathermap.org/map/precipitation_new/{z}/{x}/{y}.png?appid=YOUR_OPENWEATHERMAP_API_KEY',
    },
    {
      'name': 'Temperature',
      'url': 'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=YOUR_OPENWEATHERMAP_API_KEY',
    },
  ];

  int _selectedLayerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedLayer = _weatherLayers[_selectedLayerIndex];
    final overlayUrl = selectedLayer['url']!.replaceAll('YOUR_OPENWEATHERMAP_API_KEY', _owmApiKey);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: _initialPosition,
              zoom: 4.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.weather_app',
              ),
              TileLayer(
                urlTemplate: overlayUrl,
                userAgentPackageName: 'com.example.weather_app',
              ),
            ],
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: DropdownButton<int>(
                  value: _selectedLayerIndex,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: List.generate(_weatherLayers.length, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(_weatherLayers[index]['name']!),
                    );
                  }),
                  onChanged: (index) {
                    if (index != null) {
                      setState(() {
                        _selectedLayerIndex = index;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 
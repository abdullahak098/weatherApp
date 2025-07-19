import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/weather_provider.dart';
import '../providers/settings_provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  String _formatTemp(BuildContext context, double temp) {
    final unit = Provider.of<SettingsProvider>(context, listen: false).tempUnit;
    if (unit == TempUnit.fahrenheit) {
      return ((temp * 9 / 5) + 32).toStringAsFixed(1) + '°F';
    }
    return temp.toStringAsFixed(1) + '°C';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Test', style: Theme.of(context).textTheme.bodyLarge)),
    );
  }
} 
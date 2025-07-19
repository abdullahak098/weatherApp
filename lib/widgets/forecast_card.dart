import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/forecast.dart';
import '../providers/settings_provider.dart';
import 'package:intl/intl.dart';

class ForecastCard extends StatelessWidget {
  final Forecast forecast;
  const ForecastCard({Key? key, required this.forecast}) : super(key: key);

  String _formatTemp(BuildContext context, double temp) {
    final unit = Provider.of<SettingsProvider>(context, listen: false).tempUnit;
    if (unit == TempUnit.fahrenheit) {
      return ((temp * 9 / 5) + 32).toStringAsFixed(1) + '°F';
    }
    return temp.toStringAsFixed(1) + '°C';
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEE, MMM d, HH:mm').format(forecast.date);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.network(
          'https://openweathermap.org/img/wn/${forecast.iconCode}@2x.png',
          width: 50,
          height: 50,
        ),
        title: Text(dateStr),
        subtitle: Text(forecast.description),
        trailing: Text(
          _formatTemp(context, forecast.temperature),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
} 
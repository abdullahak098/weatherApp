import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('5-Day Forecast', style: TextStyle(color: Color(0xFF3A4D5C), fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Color(0xFF3A4D5C)),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          child: Builder(
            builder: (context) {
              if (weatherProvider.isLoading) {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
              } else if (weatherProvider.error != null) {
                return Center(
                  child: Text(
                    weatherProvider.error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error, fontWeight: FontWeight.bold),
                  ),
                );
              } else if (weatherProvider.forecast == null || weatherProvider.forecast!.isEmpty) {
                return Center(child: Text('No forecast data available.', style: Theme.of(context).textTheme.bodyLarge));
              } else {
                return ListView.builder(
                  itemCount: weatherProvider.forecast!.length,
                  itemBuilder: (context, index) {
                    final forecast = weatherProvider.forecast![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ForecastCard(forecast: forecast),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
} 
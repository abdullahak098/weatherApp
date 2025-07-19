import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../screens/feedback_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Settings', style: const TextStyle(color: Color(0xFF3A4D5C), fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Color(0xFF3A4D5C)),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      Icon(Icons.brightness_6, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      Switch(
                        value: settings.themeMode == ThemeMode.dark,
                        onChanged: (val) => settings.toggleTheme(val),
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      Icon(Icons.thermostat, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Text('Temperature Unit', style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      DropdownButton<TempUnit>(
                        value: settings.tempUnit,
                        dropdownColor: Theme.of(context).cardColor,
                        items: [
                          DropdownMenuItem(
                            value: TempUnit.celsius,
                            child: Text('Celsius (°C)', style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          DropdownMenuItem(
                            value: TempUnit.fahrenheit,
                            child: Text('Fahrenheit (°F)', style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                        onChanged: (unit) {
                          if (unit != null) settings.setTempUnit(unit);
                        },
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      Icon(Icons.straighten, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Text('Distance Unit', style: Theme.of(context).textTheme.bodyLarge),
                      const Spacer(),
                      DropdownButton<DistanceUnit>(
                        value: settings.distanceUnit,
                        dropdownColor: Theme.of(context).cardColor,
                        items: [
                          DropdownMenuItem(
                            value: DistanceUnit.kilometers,
                            child: Text('Kilometers (km)', style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          DropdownMenuItem(
                            value: DistanceUnit.miles,
                            child: Text('Miles (mi)', style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                        onChanged: (unit) {
                          if (unit != null) settings.setDistanceUnit(unit);
                        },
                        iconEnabledColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                    );
                  },
                  icon: Icon(Icons.feedback, color: Theme.of(context).colorScheme.onPrimary),
                  label: Text('Submit Feedback', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('is_logged_in', false);
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                    }
                  },
                  icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimary),
                  label: Text('Logout', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
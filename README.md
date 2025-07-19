# Weather App

A cross-platform weather application built with Flutter. This app allows users to view current weather, forecasts, and weather details for their location or any city. It also features user authentication (local registration/login), settings for units and theme, feedback submission, and beautiful dark mode support.

## Features
- User registration and login (local storage)
- View current weather by city or location
- 5-day weather forecast
- Detailed weather information (humidity, wind, pressure, sunrise/sunset)
- Weather map screen
- Settings: dark mode, temperature and distance units
- Submit feedback (stored locally)
- Logout functionality
- Responsive and modern UI with dark mode support

## Tools & Technologies Used
- **Flutter**: UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase
- **Dart**: Programming language for Flutter
- **Provider**: State management
- **shared_preferences**: Local storage for authentication and settings
- **geolocator**: Access device location
- **http**: Network requests for weather data
- **flutter_map** & **latlong2**: Map display
- **intl**: Date and number formatting
- **flutter_dotenv**: Environment variable management

## Getting Started

1. Clone the repository:
   ```sh
   git clone <repo-url>
   cd weather_app
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```sh
   flutter run
   ```

## Screenshots
_Add screenshots here if desired._

## License
MIT (or your license here)

import 'package:flutter/material.dart';
import 'package:weather_app/WeatherRepository.dart';
import 'package:weather_app/models/WeatherData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherRepository _weatherRepository = WeatherRepository();
  WeatherData? _weatherData;

  Future<void> _fetchWeatherData(String city) async {
    final weatherData = await _weatherRepository.fetchWeatherData(city);
    setState(() {
      _weatherData = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          TextField(
            onSubmitted: (city) => _fetchWeatherData(city),
            decoration: const InputDecoration(
              hintText: 'Nhập Tên Quốc Gia',
              border: OutlineInputBorder(),
            ),
          ),
          if (_weatherData != null)
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Nhiệt độ: ${_weatherData!.temperature}°C',
                      style: const TextStyle(fontSize: 24.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Độ ẩm: ${_weatherData!.humidity}%',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Tốc Độ Gió: ${_weatherData!.windSpeed} m/s',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

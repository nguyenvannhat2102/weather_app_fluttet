import 'package:dio/dio.dart';
import 'package:weather_app/models/WeatherData.dart';

class WeatherRepository {
  final Dio dio = Dio();
  final String apiKey = "b088fb7a5e07de6ad70a49c698a8d730";

  Future<WeatherData> fetchWeatherData(String city) async {
    final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey');
    final weatherDataJson = response.data;
    final weatherData = WeatherData(
      temperature: weatherDataJson['main']['temp'],
      humidity: weatherDataJson['main']['humidity'],
      windSpeed: weatherDataJson['wind']['speed'],
    );
    return weatherData;
  }
}

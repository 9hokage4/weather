import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class CityCard extends StatefulWidget {
  final String city;
  const CityCard({super.key, required this.city});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final weather = await WeatherService.fetchWeather(widget.city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Ошибка загрузки погоды: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.city),
            if (_weather != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Image.network(
                    _weather!.conditionIconUrl,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  Text('${_weather!.temperature}°'),
                ],
              ),
              const SizedBox(height: 4),
              Text(_weather!.conditionText),
            ] else ...[
              const SizedBox(height: 8),
              const CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

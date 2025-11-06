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
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final weather = await WeatherService.fetchWeather(widget.city);
      if (mounted) {
        setState(() {
          _weather = weather;
          _error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _weather = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.city, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            if (_weather != null) ...[
              Row(
                children: [
                  Image.network(
                    _weather!.conditionIconUrl,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 12),
                  Text('${_weather!.temperature}°', style: const TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 4),
              Text(_weather!.conditionText),
            ] else if (_error != null) ...[
              Text('Ошибка: $_error', style: const TextStyle(color: Colors.red)),
            ] else ...[
              const CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}
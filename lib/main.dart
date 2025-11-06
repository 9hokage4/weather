import 'package:flutter/material.dart';
import 'widgets/city_card.dart';
import 'widgets/add_city_button.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      theme: ThemeData(useMaterial3: true),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> cities = ['Омск'];

  void addCity(String city) {
    setState(() {
      cities.add(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          // if (index < cities.length) {
          return CityCard(city: 'Омск');
          //} else {
          // return AddCityButton(onAdd: addCity);
          // }
        },
      ),
    );
  }
}

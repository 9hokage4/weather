import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class AddCityButton extends StatefulWidget {
  final void Function(String city) onAdd;

  const AddCityButton({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddCityButton> createState() => _AddCityButtonState();
}

class _AddCityButtonState extends State<AddCityButton> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Center(
        child: InkWell(
          onTap: () {
            _controller.clear();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Добавить город'),
                  content: SizedBox(
                    width: 300,
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return WeatherService.searchCities(textEditingValue.text);
                      },
                      onSelected: (String selection) {
                        _controller.text = selection;
                      },
                      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: const InputDecoration(hintText: 'Название города'),
                        );
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        final city = _controller.text.trim();
                        if (city.isNotEmpty) {
                          widget.onAdd(city);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Добавить'),
                    ),
                  ],
                );
              },
            );
          },
          child: const SizedBox(
            height: 40,
            width: 40,
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
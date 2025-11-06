class Weather {
  final String city;
  final double temperature;
  final String conditionText;
  final String conditionIconUrl;

  Weather({
    required this.city,
    required this.temperature,
    required this.conditionText,
    required this.conditionIconUrl,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      conditionText: json['current']['condition']['text'],
      conditionIconUrl: 'https:${json['current']['condition']['icon']}',
    );
  }
}

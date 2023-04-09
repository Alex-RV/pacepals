import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RunScreen extends StatefulWidget {
  const RunScreen({Key? key}) : super(key: key);

  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  Future<void> _fetchWeatherData() async {
    const apiKey = '7a2d04b3c0843f83400ff4c0027602ae';
    final apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$apiKey&units=metric');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final weatherData = data['weather'][0];
      final mainData = data['main'];
      setState(() {
        _weatherDescription = weatherData['description'];
        _temperature = mainData['temp'];
      });
    } else {
      print('Failed to fetch weather data');
    }
  }

  final String _cityName = 'San Francisco';
  String _weatherDescription = '';
  double _temperature = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Run"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_cityName',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '$_temperature °C',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '$_weatherDescription',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

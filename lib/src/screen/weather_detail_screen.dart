import 'package:app_weather/src/service/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/cities.dart';
import '../model/weather.model.dart';

class WeatherDetailScreen extends StatefulWidget {
  final City city;

  const WeatherDetailScreen({super.key, required this.city});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherData weatherInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    final data = await WeatherServices()
        .fetchWeather(widget.city.latitude, widget.city.longitude);

    if (data != null) {
      setState(() {
        weatherInfo = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    final formattedTime = DateFormat('hh:mm a').format(DateTime.now());

    //Substituir com os valores reais da API
    final turnTemperatures = {
      "dawn": {"max": 22.5, "min": 18.0},
      "morning": {"max": 28.0, "min": 22.0},
      "afternoon": {"max": 30.0, "min": 26.0},
      "night": {"max": 24.0, "min": 20.0},
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade100,
              Colors.white,
            ],
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black))
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Nome da Cidade
                    Text(
                      weatherInfo.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Temperatura Atual
                    Text(
                      "${weatherInfo.temperature.current.toStringAsFixed(0)}°C",
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Condição do Clima
                    if (weatherInfo.weather.isNotEmpty)
                      Text(
                        weatherInfo.weather[0].main,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(height: 30),
                    // Imagem do Clima
                    Image.asset(
                      "assets/cloudy.png",
                      height: 150,
                    ),
                    const SizedBox(height: 30),
                    // Data e Hora
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      formattedTime,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: turnTemperatures.entries.map((entry) {
                          final turn = entry.key;
                          final maxTemp = entry.value["max"];
                          final minTemp = entry.value["min"];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  turn,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Max: ${maxTemp?.toStringAsFixed(1)}°C",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Min: ${minTemp?.toStringAsFixed(1)}°C",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    WeatherInfoCard(
                      icon: Icons.wind_power,
                      title: "Wind",
                      value: "${weatherInfo.wind.speed} km/h",
                    ),
                    WeatherInfoCard(
                      icon: Icons.water_drop,
                      title: "Humidity",
                      value: "${weatherInfo.humidity}%",
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class WeatherInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 10),
          Text(
            "$title: $value",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

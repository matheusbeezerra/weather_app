import 'package:app_weather/src/screen/city_list_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CityListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/marcozero.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.blueGrey.shade800.withOpacity(0.7),
            ),
          ),
          // Imagem centralizada
          Center(
            child: Image.asset(
              'assets/nuvem.png',
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HeaderCosmocWeather extends StatelessWidget {
  const HeaderCosmocWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cosmic Weather',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Intelligence',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Powered by NASA Data & AI 🚀',
          style: TextStyle(fontSize: 14, color: Colors.white54),
        ),
      ],
    );
  }
}
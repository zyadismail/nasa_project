import 'package:flutter/material.dart';

class CosmicActivitySummary extends StatelessWidget {
  const CosmicActivitySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    height: 150,
    width: 350,
    decoration: BoxDecoration(
      color: Color(0xff1F2937),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Text("🌞"),
            SizedBox(width: 15),
            Text(
              "Cosmic Activity Summary",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Total Events:', style: TextStyle(color: Color(0xff9CA3AF))),
            Spacer(),
            Text("5 Solar Flares"),
          ],
        ),
        Row(
          children: [
            Text(
              'Strongest Flare:',
              style: TextStyle(color: Color(0xff9CA3AF)),
            ),
            Spacer(),
            Text("X1.5 -Extreme", style: TextStyle(color: Color(0xffFF6B6B))),
          ],
        ),
        Row(
          children: [
            Text(
              'Monitoring period:',
              style: TextStyle(color: Color(0xff9CA3AF)),
            ),
            Spacer(),
            Text("Last 24 hours", style: TextStyle(color: Color(0xff60A5FA))),
          ],
        ),
      ],
    ),
  );
  }
}
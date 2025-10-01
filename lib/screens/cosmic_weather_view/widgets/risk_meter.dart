import 'package:flutter/material.dart';

class RiskMeter extends StatelessWidget {
  const RiskMeter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 180,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xff1F2937),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.warning_amber_outlined,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(height: 12),

            // Title
            const Text(
              'Risk\nAssessment\nMeter',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Progress bar
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4CAF50), // Green
                    Color(0xFFFFC107), // Yellow
                    Color(0xFFFF9800), // Orange
                    Color(0xFFF44336), // Red
                  ],
                  stops: [0.0, 0.33, 0.66, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: 75 / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Low',
                  style: TextStyle(color: Color(0xff4ECDC4), fontSize: 9),
                ),
                Text(
                  'Medium',
                  style: TextStyle(color: Color(0xffFECA57), fontSize: 9),
                ),
                Text(
                  'High',
                  style: TextStyle(color: Color(0xffFF9F43), fontSize: 9),
                ),
                Text(
                  'Extreme',
                  style: TextStyle(color: Colors.red, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        Center(
          child: Text(
            '75%',
            style: const TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  }
}


import 'package:flutter/material.dart';
import 'package:nasa_project/screens/cosmic_weather_view/cosmic_weather_view.dart';

class ImpactAssessmentContainer extends StatelessWidget {
  final List<ImpactData> impacts = [
    ImpactData('X1.5', 'extreme', const Color(0xFFE53935), '11:15 AM'),
    ImpactData('M3.2', 'high', const Color(0xFFFF9800), '07:22 AM'),
    ImpactData('C2.5', 'medium', const Color(0xFFFFC107), '01:43 AM'),
    ImpactData('C1.8', 'medium', const Color(0xFFFFC107), '10:10 PM'),
    ImpactData('B5.7', 'low', const Color(0xFF4CAF50), '07:30 PM'),
  ];

  ImpactAssessmentContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF243447),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.flash_on, color: Colors.yellow[700], size: 18),
              const SizedBox(width: 8),
              const Text(
                'Impact Assessment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Impact list
          ...impacts.map(
            (impact) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ImpactRow(
                magnitude: impact.magnitude,
                severity: impact.severity,
                color: impact.color,
                time: impact.time,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
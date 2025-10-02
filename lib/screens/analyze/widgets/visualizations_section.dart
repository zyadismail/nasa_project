
import 'package:flutter/material.dart';
import 'package:nasa_project/screens/analyze/widgets/chart_card.dart';

class VisualizationsSection extends StatelessWidget {
  const VisualizationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Visualizations',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 20),
      ChartCard(),
    ],
  );
  }
}
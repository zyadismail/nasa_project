import 'package:flutter/material.dart';
import 'package:nasa_project/screens/analyze/widgets/Header_cosmic_weather.dart';
import 'package:nasa_project/screens/analyze/widgets/cosmic_activity_summary.dart';
import 'package:nasa_project/screens/analyze/widgets/cosmic_time_line.dart';
import 'package:nasa_project/screens/analyze/widgets/impacr_assessment.dart';
import 'package:nasa_project/screens/analyze/widgets/live_indicator.dart';
import 'package:nasa_project/screens/analyze/widgets/magnetic_storm.dart';
import 'package:nasa_project/screens/analyze/widgets/risk_meter.dart';
import 'package:nasa_project/screens/analyze/widgets/solar_activity_spectrum.dart';
import 'package:nasa_project/screens/analyze/widgets/summary_card.dart';
import 'package:nasa_project/screens/analyze/widgets/visualizations_section.dart';
import 'package:nasa_project/widgets/stairs_widget.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0C0F1C), Color(0xFF1A1F36)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: StarPainter())),
              SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderCosmocWeather(),
                    const SizedBox(height: 10),
                    LiveIndicator(),
                    const SizedBox(height: 30),
                    SummaryCard(),
                    const SizedBox(height: 30),
                    VisualizationsSection(),
                    const SizedBox(height: 20),
                    Text("Visualizations"),
                    Row(
                      children: [
                        SolarActivitySpectrum(),
                        const SizedBox(width: 10),
                        RiskMeter(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        CosmicTimeline(),
                        const SizedBox(width: 10),
                        MagneticStorm(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Cosmic Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Comprehensive space weather analysis",
                      style: TextStyle(color: Color(0xff9CA3AF)),
                    ),
                    SizedBox(height: 20),
                    CosmicActivitySummary(),
                    SizedBox(height: 16),
                    ImpactAssessmentContainer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImpactRow extends StatelessWidget {
  final String magnitude;
  final String severity;
  final Color color;
  final String time;

  const ImpactRow({
    Key? key,
    required this.magnitude,
    required this.severity,
    required this.color,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Magnitude
        SizedBox(
          width: 45,
          child: Text(
            magnitude,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Colored dot
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 23),

        // Severity
        Expanded(
          child: Text(
            severity,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        // Time
        Text(
          time,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ImpactData {
  final String magnitude;
  final String severity;
  final Color color;
  final String time;

  ImpactData(this.magnitude, this.severity, this.color, this.time);
}

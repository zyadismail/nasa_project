import 'package:flutter/material.dart';
import 'package:nasa_project/widgets/stairs_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CosmicWeatherScreen extends StatelessWidget {
  const CosmicWeatherScreen({super.key});

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
              Positioned(child: CustomPaint(painter: StarPainter())),
              SingleChildScrollView(
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
                    _buildVisualizationsSection(),
                    const SizedBox(height: 20),
                    Text("Visualizations"),
                    Row(
                      children: [
                        _buildSolarActivitySpectrum(),
                        const SizedBox(width: 10),
                        _buildRiskMeter(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        _buildCosmicTimeLine(),
                        const SizedBox(width: 10),
                        _buildMagneticStorm(),
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
                    _buildCosmicActivitySummary(),
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

class LiveIndicator extends StatelessWidget {
  const LiveIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFF4CAF50),
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      const Text(
        'Live Data',
        style: TextStyle(
          color: Color(0xFF4CAF50),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: const Color(0xff1F2937),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Solar Activity Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              value: '5',
              label: 'Solar\nFlares',
              color: Colors.white,
            ),
            _buildStatItem(
              value: 'X1.5',
              label: 'Strongest\nFlare',
              color: const Color(0xFFFF6B6B),
            ),
            _buildStatItem(
              value: 'Last\n21\nHours',
              label: 'Monitoring',
              color: const Color(0xFF64B5F6),
              isMultiLine: true,
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2C3E5F),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Live Data',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'View Cosmic Report',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  }
}



Widget _buildStatItem({
  required String value,
  required String label,
  required Color color,
  bool isMultiLine = false,
}) {
  return Column(
    children: [
      Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isMultiLine ? 16 : 28,
          fontWeight: FontWeight.bold,
          color: color,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white60,
          height: 1.3,
        ),
      ),
    ],
  );
}

Widget _buildVisualizationsSection() {
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
      _buildChartCard(),
    ],
  );
}

Widget _buildChartCard() {
  final List<SolarData> data = [
    SolarData('A', 10),
    SolarData('B', 18),
    SolarData('C', 8),
    SolarData('M', 3),
    SolarData('X', 1),
  ];
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xff1F2937),
      borderRadius: BorderRadius.circular(20),
      // boxShadow: [
      //   BoxShadow(
      //     color: Color(0xff1F2937),
      //     blurRadius: 10,
      //     offset: const Offset(0, 5),
      //   ),
      // ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text('🚀', style: TextStyle(fontSize: 20)),
            SizedBox(width: 8),
            Text(
              'Solar Activity Spectrum',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 150,
          child: SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0.5),
            ),
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: false),
            series: [
              ColumnSeries<SolarData, String>(
                dataSource: data,
                xValueMapper: (SolarData solar, _) => solar.classType,
                yValueMapper: (SolarData solar, _) => solar.value,
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff4ECDC4),
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _buildSolarActivitySpectrum() {
  final List<SolarData> data = [
    SolarData('A', 10),
    SolarData('B', 18),
    SolarData('C', 8),
    SolarData('M', 3),
    SolarData('X', 1),
  ];
  return Container(
    height: 250,
    width: 180,
    decoration: BoxDecoration(
      color: Color(0xff1F2937),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: const Row(
            children: [
              Text('🚀', style: TextStyle(fontSize: 14)),
              SizedBox(width: 20),
              Text(
                'Solar\nActivity\nSpectrum',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 160,
          width: 170,
          child: SfCartesianChart(
            enableAxisAnimation: true,
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: Colors.white),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(color: Colors.white),
              majorGridLines: const MajorGridLines(width: 0.5),
            ),
            plotAreaBorderWidth: 0,
            legend: Legend(isVisible: false),
            series: [
              ColumnSeries<SolarData, String>(
                dataSource: data,
                xValueMapper: (SolarData solar, _) => solar.classType,
                yValueMapper: (SolarData solar, _) => solar.value,
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff4ECDC4),
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Container _buildRiskMeter() {
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

Container _buildCosmicTimeLine() {
  return Container(
    width: 180,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xff1F2937),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        // Warning icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('⏱️', style: TextStyle(fontSize: 20)),
            const Text(
              'Cosmic\nTimeLine',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
        SizedBox(height: 53),
        Center(
          child: Text(
            "Interactive timeline\nview",
            style: TextStyle(
              color: Color(0xff9CA3AF),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}

Container _buildMagneticStorm() {
  return Container(
    width: 180,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xff1F2937),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        // Warning icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('🌀', style: TextStyle(fontSize: 20)),
            const Text(
              'Magnetic\nStorm\nSimulation',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
        SizedBox(height: 53),
        Center(
          child: Text(
            "Interactive timeline\nview",
            style: TextStyle(
              color: Color(0xff9CA3AF),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}

Container _buildCosmicActivitySummary() {
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

class SolarData {
  final String classType;
  final double value;
  SolarData(this.classType, this.value);
}

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

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({super.key});

  @override
  Widget build(BuildContext context) {
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
      boxShadow: [
        BoxShadow(
          color: Color(0xff1F2937),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
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
            legend: Legend(isVisible: false,),
            series: [
              ColumnSeries<SolarData, String>(
                dataSource: data,
                xValueMapper: (SolarData solar, _) => solar.classType,
                yValueMapper: (SolarData solar, _) => solar.value,
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff4ECDC4),
                dataLabelSettings: DataLabelSettings(isVisible: false),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  }
}

class SolarData {
  final String classType;
  final double value;
  SolarData(this.classType, this.value);
}
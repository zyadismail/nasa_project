import 'package:flutter/material.dart';
import 'package:nasa_project/screens/cosmic_weather_view/widgets/chart_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SolarActivitySpectrum extends StatelessWidget {
  const SolarActivitySpectrum({super.key});

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
}
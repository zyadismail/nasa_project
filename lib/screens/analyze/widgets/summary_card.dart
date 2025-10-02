import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_project/cubit/cubit/solar_flares_cubit.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolarFlaresCubit, SolarFlaresState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SolarFlaresCubit.get(context);
        if (state is SolarFlaresSuccess) {
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
                      value: cubit.saveSunModel!.flaresCount.toString(),
                      label: 'Solar\nFlares',
                      color: Colors.white,
                    ),
                    _buildStatItem(
                      value: cubit.saveSunModel!.report!.strongestFlare!.classType!,
                      label: 'Strongest\nFlare',
                      color: const Color(0xFFFF6B6B),
                    ),
                    _buildStatItem(
                      value: "Last\n24\nhours",
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
        }else if(state is SolarFlaresLoading){
          return Center(child: CircularProgressIndicator());
        }else{
          return SizedBox();
        }
      },
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

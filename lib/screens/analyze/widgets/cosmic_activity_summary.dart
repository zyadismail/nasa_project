import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_project/cubit/analyze/solar_flares_cubit.dart';

class CosmicActivitySummary extends StatelessWidget {
  const CosmicActivitySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolarFlaresCubit, SolarFlaresState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is SolarFlaresSuccess) {
          var cubit  = SolarFlaresCubit.get(context);
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
                    Text(
                      'Total Events:',
                      style: TextStyle(color: Color(0xff9CA3AF)),
                    ),
                    Spacer(),
                    Text(cubit.saveSunModel!.report!.totalFlares.toString(), style: TextStyle(color: Colors.white),),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Strongest Flare:',
                      style: TextStyle(color: Color(0xff9CA3AF)),
                    ),
                    Spacer(),
                    Text(
                      "${cubit.saveSunModel!.report!.strongestFlare!.classType} - ${cubit.saveSunModel!.report!.strongestFlare!.riskLevel}",
                      style: TextStyle(color: Color(0xffFF6B6B)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Monitoring period:',
                      style: TextStyle(color: Color(0xff9CA3AF)),
                    ),
                    Spacer(),
                    Text(
                      "Last 24 hours",
                      style: TextStyle(color: Color(0xff60A5FA)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }else if(state is SolarFlaresLoading){
          return Center(child: CircularProgressIndicator(),);
        }else{
          return SizedBox();
        }
      },
    );
  }
}

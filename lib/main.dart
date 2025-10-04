import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_project/cubit/analyze/solar_flares_cubit.dart';
import 'package:nasa_project/network/dio_helper1.dart';
import 'package:nasa_project/screens/home/home_screen.dart';

void main() async {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolarFlaresCubit()..SolarActivitySummry(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  HomeScreen(),
      ),
    );
  }
}

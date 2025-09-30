// import 'package:flutter/material.dart';
// import 'package:nasa_project/home/home_view.dart';

// void main(){
//   runApp(MyApp());
// }


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeView(),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:nasa_project/screens/cosmic_weather_view/cosmic_weather_view.dart';

void main() {
  runApp(const CosmicWeatherApp());
}

class CosmicWeatherApp extends StatelessWidget {
  const CosmicWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CosmicWeatherScreen(),
    );
  }
}

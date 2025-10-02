import 'package:flutter/material.dart';
import 'package:nasa_project/screens/about/about_us_screen.dart';
import 'package:nasa_project/screens/analyze/analyze_screen.dart';
import 'package:nasa_project/screens/game/game_screen.dart';
import 'package:nasa_project/widgets/stairs_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: StarPainter())),
              Positioned.fill(child: Image.asset("assets/images/sun.jpg")),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    HomeHeader(),
                    SizedBox(height: 30),
                    HomeContent(),
                    SizedBox(height: 400),
                    CustomButtons(),
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

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SolarDefenderGame()),
                );
              },
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Color(0xffFECA57),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/images/play.png"),
              ),
            ),
            SizedBox(height: 10),
            Text("Play", style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AnalyzeScreen()),
                );
              },
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Color(0xff45B7D1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/images/analyze.png"),
              ),
            ),
            SizedBox(height: 10),
            Text("analyze", style: TextStyle(color: Colors.white)),
          ],
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AboutUsScreen()),
                );
              },
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Color(0xff4ECDC4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/images/about.png"),
              ),
            ),
            SizedBox(height: 10),
            Text("about", style: TextStyle(color: Colors.white),),
          ],
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Defend Earth, Space\ncommander!🚀",
          style: TextStyle(
            color: Color(0xff4ECDC4),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          "Earth needs your protection against solar\nstorms!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/images/app_logo.png"),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Solar Defender",
              style: TextStyle(
                color: Color(0xff00FFFF),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              "Protect Earth from Storms 🌟",
              style: TextStyle(color: Color(0xffFECA57), fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

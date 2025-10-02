import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset("assets/images/sun.jpg")),
            Container(color: Colors.black54),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Image.asset("assets/images/app_logo.png"),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

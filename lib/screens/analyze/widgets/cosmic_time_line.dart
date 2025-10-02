import 'package:flutter/material.dart';

class CosmicTimeline extends StatelessWidget {
  const CosmicTimeline({super.key});

  @override
  Widget build(BuildContext context) {
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
}

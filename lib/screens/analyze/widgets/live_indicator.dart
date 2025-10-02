import 'package:flutter/material.dart';

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
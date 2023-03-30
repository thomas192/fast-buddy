import 'package:flutter/material.dart';

class StatsPodium extends StatelessWidget {
  final String numFasts;
  final String avgDuration;
  final String maxDuration;

  const StatsPodium({
    Key? key,
    required this.numFasts,
    required this.avgDuration,
    required this.maxDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double contextHeight = MediaQuery.of(context).size.height;
    double contextWidth = MediaQuery.of(context).size.width;
    double bubbleSize = contextWidth * 0.32;
    return Stack(
      children: [
        Positioned(
          top: contextHeight * 0.03,
          left: contextWidth * 0.04,
          child: _buildBubble(avgDuration, 'Avg.', bubbleSize),
        ),
        Positioned(
          top: contextHeight * 0.03,
          right: contextWidth * 0.04,
          child: _buildBubble(maxDuration, 'Max.', bubbleSize),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _buildBubble(numFasts, 'Fasts', bubbleSize),
        ),
      ],
    );
  }

  Widget _buildBubble(String value, String label, double size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            border: Border.all(
              color: Colors.white,
              width: size * 0.01,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: size * 0.2, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size * 0.05),
              Text(
                label,
                style: TextStyle(fontSize: size * 0.16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

}

import 'package:flutter/material.dart';

class FastProgressBar extends StatefulWidget {
  final double progress;

  FastProgressBar({required this.progress});

  @override
  _FastProgressBarState createState() => _FastProgressBarState();
}

class _FastProgressBarState extends State<FastProgressBar> {
  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    return CircularProgressIndicator(
      value: widget.progress,
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      strokeWidth: contextWidth * 0.04,
    );
  }
}

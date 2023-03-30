import 'package:flutter/material.dart';
import 'package:fast_buddy/fast/widgets/FastButton.dart';
import 'package:fast_buddy/fast/widgets/FastProgressBar.dart';

class Fast extends StatefulWidget {
  final Function() onPressed;
  final String label;
  final double progress;

  Fast({required this.onPressed, required this.label, required this.progress});

  @override
  _FastState createState() => _FastState();
}

class _FastState extends State<Fast> {
  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    final buttonSize = contextWidth * 0.8;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Stack(
        children: [
          Positioned.fill(
            child: FastProgressBar(progress: widget.progress)
          ),
          FastButton(
            onPressed: widget.onPressed,
            label: widget.label,
          ),
        ],
      ),
    );
  }
}

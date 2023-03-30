import 'package:flutter/material.dart';
import 'dart:async';

class FastButton extends StatefulWidget {
  final Function() onPressed;
  final String label;

  FastButton({required this.onPressed, required this.label});

  @override
  _FastButtonState createState() => _FastButtonState();
}

class _FastButtonState extends State<FastButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
    Timer(Duration(seconds: 1), () {
      if (_isPressed) {
        widget.onPressed();
      }
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final contextWidth = MediaQuery.of(context).size.width;
    final buttonSize = contextWidth * 0.8;
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isPressed
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
          ),
          padding: EdgeInsets.all(buttonSize / 4),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(fontSize: buttonSize / 10, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

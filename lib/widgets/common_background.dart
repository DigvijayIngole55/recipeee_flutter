import 'package:flutter/material.dart';

class CommonBackground extends StatelessWidget {
  final Widget child;

  const CommonBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.8), // Semi-transparent overlay
        ),
        child,
      ],
    );
  }
}

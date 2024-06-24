import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingRobotWidget extends StatelessWidget {
  final double height;

  const LoadingRobotWidget({super.key, required this.height});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // Adjust the size as needed
            height: height / 2, // Adjust the size as needed
            child: RiveAnimation.asset(
              'assets/cooking_animation.riv',
              fit: BoxFit.contain,
              // animations: [

              // ], // Assuming 'slow' is a slower animation variant in your Rive file
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Let Him Cook!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Adjust the color as needed
            ),
          ),
          SizedBox(height: 10),
          Text(
            'We are preparing your personalized recipes. This might take a few seconds. Please wait...',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54, // Adjust the color as needed
            ),
          ),
        ],
      ),
    );
  }
}

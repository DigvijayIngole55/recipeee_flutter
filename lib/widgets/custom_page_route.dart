import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: Duration(seconds: 2),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Stack(
              children: [
                ScaleTransition(
                  scale: animation,
                  child: RiveAnimation.asset(
                    'assets/cooking_animation.riv',
                    fit: BoxFit.cover,
                  ),
                ),
                FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ],
            );
          },
        );
}

import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final Widget child;

  const CommonCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: Container(
        height: screenHeight,
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

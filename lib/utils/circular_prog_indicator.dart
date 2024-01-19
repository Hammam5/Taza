// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_super/utils/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Animates the rotation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Transform.rotate(
        angle: -0.5 * 3.1415, // Adjust the starting angle if needed
        child: const CircularStepProgressIndicator(
          totalSteps: 12,
          currentStep: 6,
          selectedColor: Constants.primaryColor,
          unselectedColor: Colors.green,
          selectedStepSize: 10.0,
          width: 60,
          height: 60,
          circularDirection: CircularDirection.clockwise,
          gradientColor: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Constants.primaryColor, Constants.secondaryColor],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_super/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String text;
  final double fontSize;

  const CustomAppBar({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Constants.primaryColor,
        title: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'Gagalin',
                fontSize: fontSize,
                letterSpacing: 0.8,
                shadows: const [
                  Shadow(
                    blurRadius: 60.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  )
                ],
                color: Constants.secondaryColor),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:go_super/utils/constants.dart';


class ErrorSnackBar {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text('$errorMessage.', style: const TextStyle(fontSize: 17),
          ),
        ),
        backgroundColor: Constants.errorColor,
      ),
    );
  }
}

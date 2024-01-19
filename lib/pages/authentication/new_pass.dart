// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/designs/error_snackbar.dart';
import 'package:go_super/designs/textformfields.dart';
import 'package:go_super/models/authentication_models/newpass_model.dart';
import 'package:go_super/pages/authentication/login.dart';
import 'package:go_super/services/authentication_services/newpass_api.dart';
import 'package:go_super/utils/constants.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String errorMessage = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          'Create New Password',
          style: TextStyle(
              fontFamily: 'Gagalin',
              fontSize: 30,
              letterSpacing: 0.8,
              shadows: [
                Shadow(
                  blurRadius: 60.0,
                  color: Colors.black,
                  offset: Offset(5.0, 5.0),
                )
              ],
              color: Color.fromARGB(255, 236, 236, 205)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            CustomPassFormField(controller: _passwordController),
            const SizedBox(height: 20),
            ConfirmPassFormField(controller: _confirmPasswordController),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyles.raisedButtonStyle,
              onPressed: () async {
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (password.isNotEmpty && confirmPassword.isNotEmpty) {
                  if (password == confirmPassword) {
                    NewPasswordModel newPassword =
                        NewPasswordModel(password: password);
                    bool success =
                        await PasswordAPI.setNewPassword(newPassword);

                    if (success) {
                      Get.offAll(const LoginPage());
                      print('Password set successfully: $password');
                    } else {
                      // Error setting password
                      print('Error setting password.');
                    }
                  }
                } else if (password.isEmpty && confirmPassword.isEmpty) {
                  errorMessage = 'Please write your new password';
                  ErrorSnackBar.showErrorSnackBar(context, errorMessage);
                } else {
                  errorMessage = 'Passwords do not match';
                  ErrorSnackBar.showErrorSnackBar(context, errorMessage);
                }
              },
              child: const Text('Set Password'),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/designs/error_snackbar.dart';
import 'package:go_super/models/authentication_models/otp_model.dart';
import 'package:go_super/pages/authentication/new_pass.dart';
import 'package:go_super/services/authentication_services/otp_api.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController otpController = TextEditingController();
  String errorMessage = '';

  void otpcode() async {
    String otp = otpController.text;
    if (otp.length == 6) {
      bool isValid = true;
      for (int i = 0; i < otp.length; i++) {
        if (!isNumeric(otp[i])) {
          isValid = false;
          break;
        }
      }

      if (isValid) {
        OTPCheck otpCheck = OTPCheck(otp: otp);
        bool? otpmatch = await OTPapi.sendOTP(otpCheck);
        if (otpmatch == true) {
          Get.off(const NewPasswordPage());
        } else {
          errorMessage = 'Email not registered before';
          ErrorSnackBar.showErrorSnackBar(context, errorMessage);
        }
      } else {
        errorMessage = 'Please enter a valid 6-digit code';
        ErrorSnackBar.showErrorSnackBar(context, errorMessage);
      }
    } else {
      errorMessage = 'Please write the 6-digit code sent to your email';
      ErrorSnackBar.showErrorSnackBar(context, errorMessage);
    }
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        // ... your app bar code remains unchanged
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30),
              // ... your other UI code remains unchanged
              const SizedBox(height: 20),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Constants.primaryColor, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  counterText: '',
                  hintText: 'Enter 6-digit code',
                ),
                onChanged: (value) {
                  // Handle OTP verification logic here if needed
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ButtonStyles.raisedButtonStyle,
                onPressed: otpcode,
                child: const Text('Proceed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

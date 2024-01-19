import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/designs/error_snackbar.dart';
import 'package:go_super/designs/textformfields.dart';
import 'package:go_super/models/authentication_models/forgotpass_model.dart';
import 'package:go_super/pages/authentication/otp.dart';
import 'package:go_super/services/authentication_services/forgotpass_api.dart';
import 'package:go_super/utils/constants.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController username = TextEditingController();
  String errorMessage = '';
  bool isLinkSent = false;

  void requestReset() async {
    String email = username.text;
    ForgotPassRequest forgotPassRequest = ForgotPassRequest(email: email);
    bool? isLinkSent = await ForgotPasswordAPI.sendResetLink(forgotPassRequest);
    if (isLinkSent == true) {
      Get.to(const OTP());
    } else {
      errorMessage = 'Email not registered before';
      setState(() {
        ErrorSnackBar.showErrorSnackBar(context, errorMessage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secondaryColor,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: (){
          Navigator.of(context).pop();
        },
        alignment: Alignment.bottomLeft,
        color: Constants.secondaryColor,
        visualDensity: VisualDensity.comfortable),
        backgroundColor: Constants.primaryColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Reset Password',
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
                  color: Constants.secondaryColor),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 25),
              Image.asset('images/SUPER GO 8.png'),
              const SizedBox(height: 20),
              const Text(
                'Forgot Your Password?',
                style: TextStyle(
                    fontFamily: 'Gagalin',
                    fontSize: 30,
                    letterSpacing: 0.8,
                    color: Constants.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Please enter your email address. We will send you a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, fontFamily: 'Gagalin'),
              ),
              const SizedBox(height: 20.0),
              CustomEmailFormField(controller: username),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  requestReset();
                },
                style: ButtonStyles.raisedButtonStyle,
                child: const Text(
                  'Send Reset Link',
                  style: TextStyle(
                      fontFamily: 'Gagalin', letterSpacing: 0.8, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

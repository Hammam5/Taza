import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/designs/error_snackbar.dart';
import 'package:go_super/designs/textformfields.dart';
import 'package:go_super/pages/home_page/home_page.dart';
import 'package:go_super/services/authentication_services/login_api.dart';
import 'package:go_super/pages/authentication/forgot_password.dart';
import 'package:go_super/pages/authentication/sign_up.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/models/authentication_models/login_model.dart';
import 'package:go_super/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController pass = TextEditingController();
  String errorMessage = '';

  void performLogin() async {
    String email = username.text;
    String password = pass.text;

    LoginRequest loginRequest = LoginRequest(email: email, password: password);

    String? token = await LoginAPI.requestLogin(loginRequest);
    if (token != null) {
      Get.offAll(const HomePage());
    } else {
      errorMessage = 'Invalid credentials. Please try again.';
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
        backgroundColor: Constants.primaryColor,
        title: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(
                fontFamily: 'Gagalin',
                fontSize: 45,
                letterSpacing: 0.8,
                shadows: [
                  Shadow(
                    blurRadius: 60.0,
                    color: Constants.tertiaryColor,
                    offset: Offset(5.0, 5.0),
                  )
                ],
                color: Constants.secondaryColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Image.asset(
                  "images/SUPER GO 3.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomEmailFormField(
                  controller: username,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: CustomPassFormField(
                    controller: pass,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(const ForgotPass());
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Gagalin',
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 6, 80, 7),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyles.raisedButtonStyle,
                  onPressed: () {
                    performLogin();
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontFamily: 'Gagalin',
                        letterSpacing: 0.8,
                        fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Column(
                  children: [
                    Text(
                      "---------- OR ----------",
                      style: TextStyle(fontSize: 20, fontFamily: 'Gagalin'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(const SignupPage());
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gagalin',
                            letterSpacing: 0.8,
                            color: Color.fromARGB(255, 6, 80, 7),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

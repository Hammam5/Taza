// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/designs/error_snackbar.dart';
import 'package:go_super/designs/textformfields.dart';
import 'package:go_super/models/authentication_models/signup_model.dart';
import 'package:go_super/pages/authentication/login.dart';
import 'package:go_super/services/authentication_services/signup_api.dart';
import 'package:go_super/utils/constants.dart';
import 'package:go_super/utils/getx.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isCheckBoxChecked = false;
  String errorMessage = '';
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController pass = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final TextEditingController addres = TextEditingController();
  final _formmkey = GlobalKey<FormState>();
  final UserController userController = Get.put(UserController());

  void performSignUp() async {
    String email = username.text;
    String password = pass.text;
    String firstname = fname.text;
    String lastname = lname.text;
    String birthdate = dobController.text;
    String address = addres.text;

    SignUpRequest signUpRequest = SignUpRequest(
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
        address: address,
        birthdate: birthdate);

    bool? isRegistered = await SignUpAPI.registerUser(signUpRequest);
    if (isRegistered == true) {
      userController.setUserDetails(email, firstname, lastname);
      Get.offAll(const LoginPage());
    } else {
      errorMessage = 'Wrong Information please check your entries.';
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
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
            alignment: Alignment.bottomLeft,
            color: Constants.secondaryColor,
            visualDensity: VisualDensity.comfortable),
        backgroundColor: Constants.primaryColor,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontFamily: 'Gagalin',
                  fontSize: 45,
                  letterSpacing: 0.8,
                  shadows: [
                    Shadow(
                      blurRadius: 60.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    )
                  ],
                  color: Color.fromARGB(255, 245, 245, 220)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formmkey,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Image.asset("images/SUPER GO 6.png"),
                    Container(height: 3, color: Constants.primaryColor),
                    const SizedBox(height: 10),
                    CustomEmailFormField(
                      controller: username,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextFormField(
                          controller: fname,
                          keyboardType: TextInputType.text,
                          labelText: "First Name",
                          obscureText: false,
                          prefixIcon: Icons.person,
                          hintText: "Write your first name",
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextFormField(
                            controller: lname,
                            keyboardType: TextInputType.text,
                            labelText: "Last Name",
                            obscureText: false,
                            prefixIcon: Icons.person,
                            hintText: "Write your family name",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomPassFormField(
                      controller: pass,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: addres,
                      keyboardType: TextInputType.text,
                      labelText: "Address",
                      obscureText: false,
                      prefixIcon: Icons.house,
                      hintText: "Enter your address",
                    ),
                    const SizedBox(height: 20),
                    DOBTextField(controller: dobController),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Checkbox(
                          value: _isCheckBoxChecked,
                          onChanged: (value) {
                            setState(() {
                              _isCheckBoxChecked = value!;
                            });
                          },
                        ),
                        const Text('I agree to the terms and conditions'),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ButtonStyles.raisedButtonStyle,
                      onPressed: () {
                        if (_formmkey.currentState!.validate() &&
                            _isCheckBoxChecked) {
                          performSignUp();
                        } else if (!_isCheckBoxChecked) {
                          errorMessage =
                              'Please agree to the terms and conditions';
                          ErrorSnackBar.showErrorSnackBar(
                              context, errorMessage);
                        } else {
                          errorMessage = 'Please fill all the fields';
                          ErrorSnackBar.showErrorSnackBar(
                              context, errorMessage);
                        }
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'Gagalin',
                            letterSpacing: 0.8),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}

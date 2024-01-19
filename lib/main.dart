import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/pages/authentication/forgot_password.dart';
import 'package:go_super/pages/authentication/otp.dart';
import 'package:go_super/pages/authentication/sign_up.dart';
import 'package:go_super/pages/home_page/home_page.dart';
import 'package:go_super/pages/authentication/login.dart';
import 'package:go_super/utils/circular_prog_indicator.dart';
import 'package:go_super/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    return userToken != null && userToken.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Taza',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
              useMaterial3: true,
            ),
            getPages: [
              GetPage(name: "/login", page: () => const LoginPage()),
              GetPage(name: "/home", page: () => const HomePage()),
              GetPage(name: "/signup", page: () => const SignupPage()),
              GetPage(name: "/forgot", page: () => const ForgotPass()),
              GetPage(name: "/otp", page: () => const OTP()),
            ],
            initialRoute: snapshot.data == true ? "/home" : "/login",
            //home: const HomePage(),
          );
        } else {
          return const MaterialApp(
            home: CustomCircularProgressIndicator(),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/designs/bottomnavbar.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/models/authentication_models/sign_out.dart';
import 'package:go_super/pages/authentication/login.dart';
import 'package:go_super/utils/constants.dart';
import 'package:go_super/utils/getx.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          title: const Text(
            'Taza',
            style: TextStyle(
              fontFamily: 'Gagalin',
              fontSize: 35,
              letterSpacing: 0.8,
              shadows: [
                Shadow(
                  blurRadius: 60.0,
                  color: Constants.tertiaryColor,
                  offset: Offset(5.0, 5.0),
                )
              ],
              color: Constants.secondaryColor,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Constants.secondaryColor,
                backgroundImage: AssetImage('images/defuser.png'),
                radius: 50,
              ),
              const SizedBox(height: 20),
              Text(
                '${UserController().userFirstName} ${UserController().userLastName}',
                style: const TextStyle(fontSize: 24, fontFamily: 'Gagalin'),
              ),
              Text(
                UserController().userEmail,
                style: const TextStyle(fontSize: 16, fontFamily: 'Gagalin'),
              ),
              const SizedBox(height: 60),
              OutlinedButton(
                style: ButtonStyles.raisedButtonStyle,
                onPressed: () async {
                  await AuthService.signOut();
                  Get.offAll(const LoginPage());
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            backgroundColor: Constants.secondaryColor,
            shape: const CircleBorder(eccentricity: 1.0),
            child: Image.asset('images/SUPER GO 3.png',
                height: 55, width: 55, alignment: Alignment.center)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavBar(bottomNavIndex: 3));
  }
}

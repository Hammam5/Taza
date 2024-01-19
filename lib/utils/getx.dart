import 'package:get/get.dart';

class UserController extends GetxController {
  String userEmail = '';
  String userFirstName = '';
  String userLastName = '';

  void setUserDetails(String email, String firstName, String lastName) {
    userEmail = email;
    userFirstName = firstName;
    userLastName = lastName;
  }
}


import 'dart:convert';
import 'package:go_super/models/authentication_models/newpass_model.dart';
import 'package:http/http.dart' as http;


class PasswordAPI {
  static Future<bool> setNewPassword(NewPasswordModel newPassword) async {
    final url = Uri.parse('http://34.125.255.35/api/reset_password'); // Replace with your API endpoint

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(newPassword.toJson()),
      );

      if (response.statusCode == 203) {
        // Password set successfully
        return true;
      } else {
        // Error setting password
        return false;
      }
    } catch (e) {
      // Error occurred while connecting to the server
      return false;
    }
  }
}

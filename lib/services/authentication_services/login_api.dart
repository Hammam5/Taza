// ignore_for_file: avoid_print

import 'package:go_super/models/authentication_models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  static Future<String?> requestLogin(LoginRequest loginRequest) async {
    try {
      var url = Uri.parse('http://34.125.255.35/api/login');
      String jsonBody = jsonEncode(loginRequest.toJson());
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;odata=verbose',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String? userToken = responseBody["body"];
        print(userToken);
        if (userToken != null) {
          // Save the token to SharedPreferences
          await saveToken(userToken);
          return userToken;
        }
      } else if(response.statusCode == 401){
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String? error = responseBody["error"];
        print(error);
      } else {
        return null;
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      return null;
    }
    return null;
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }
}

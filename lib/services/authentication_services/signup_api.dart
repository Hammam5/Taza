// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:go_super/models/authentication_models/signup_model.dart';
import 'package:http/http.dart' as http;

class SignUpAPI {
  static Future<dynamic> registerUser(SignUpRequest signUpRequest) async {
    var url = Uri.parse('http://34.125.255.35/api/register');
    String jsonBody = jsonEncode(signUpRequest.toJson());
    print(jsonBody);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;odata=verbose',
        },
        body: jsonBody,
      );

      if (response.statusCode == 201) {
        bool isRegistered = true;
        print(jsonBody);
        return isRegistered;
      } else {
        print(jsonBody);
        return null;
      }
    } on SocketException catch (e) {
      print('Socket Exception: $e');
      return null;
    } on FormatException catch (e) {
      print('Format Exception: $e');
      return null;
    } catch (e) {
      print('Exception during HTTP request: $e');
      return null;
    }
  }
}

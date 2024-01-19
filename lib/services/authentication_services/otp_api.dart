// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';


import 'package:go_super/models/authentication_models/otp_model.dart';
import 'package:http/http.dart' as http;

class OTPapi {
  static Future<dynamic> sendOTP(
      OTPCheck otpCheck) async {
    var url = Uri.parse('https://reqres.in/api/users');
    String jsonBody = jsonEncode(otpCheck.toJson());
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;odata=verbose',
        },
        body: jsonBody,
      );

      if (response.statusCode == 201) {
        bool otpmatch = true;
        return otpmatch;
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

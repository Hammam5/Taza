// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:go_super/models/authentication_models/forgotpass_model.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordAPI {
  static Future<dynamic> sendResetLink(
      ForgotPassRequest forgotPassRequest) async {
    var url = Uri.parse('http://34.125.255.35/api/forgot_password');
    String jsonBody = jsonEncode(forgotPassRequest.toJson());
    print(jsonBody);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json;odata=verbose',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        bool isLinkSent = true;
        return isLinkSent;
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

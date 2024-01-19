// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:go_super/utils/getx.dart';
import 'package:http/http.dart' as http;

enum CartResponseStatus {
  addedToCart,
  alreadyExists,
  failedToAdd,
  removedfromCart,
  failedToRemove,
}

class CartService {
  Future<CartResponseStatus> addToCart(int productId) async {
    try {
      final String userEmail = UserController().userEmail;

      final Map<String, dynamic> requestBody = {
        'email': userEmail,
        'productId': productId,
      };

      final response = await http.post(
        Uri.parse('http://34.125.255.35/api/add_to_cart'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return CartResponseStatus.addedToCart;
      } else if (response.statusCode == 201) {
        return CartResponseStatus.alreadyExists;
      } else {
        return CartResponseStatus.failedToAdd;
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      return CartResponseStatus.failedToAdd;
    }
  }

  Future<CartResponseStatus> removefromCart(int productId) async {
    try {
      final String userEmail = UserController().userEmail;

      final Map<String, dynamic> requestBody = {
        'email': userEmail,
        'productId': productId,
      };

      final response = await http.post(
        Uri.parse('http://34.125.255.35/api/remove_from_cart'),
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return CartResponseStatus.removedfromCart;
      } else {
        return CartResponseStatus.failedToRemove;
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      return CartResponseStatus.failedToAdd;
    }
  }
}

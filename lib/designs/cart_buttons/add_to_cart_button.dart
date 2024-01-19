// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/pages/home_page/cart_page.dart';
import 'package:go_super/services/main_pages_services/cart_services.dart';

class AddToCartButton extends StatelessWidget {
  final int productId;

  const AddToCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        CartResponseStatus responseStatus =
            await CartService().addToCart(int.parse(productId as String));
        if (responseStatus == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Product added to cart!'),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'View Cart',
                onPressed: () {
                  Get.off(const CartPage(userId: 1));
                },
              ),
            ),
          );
        } else if (responseStatus == 400) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product already exists in cart!'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add product to cart!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: const Text('Add to Cart'),
    );
  }
}

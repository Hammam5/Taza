// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:go_super/services/main_pages_services/cart_services.dart';

class RemoveFromCartButton extends StatelessWidget {
  final int productId;

  const RemoveFromCartButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        CartResponseStatus responseStatus =
            await CartService().removefromCart(int.parse(productId as String));
        if (responseStatus == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product removed from cart!'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to remove product from cart!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: const Text('Add to Cart'),
    );
  }
}

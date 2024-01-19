import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_super/designs/bottomnavbar.dart';
import 'package:go_super/services/main_pages_services/cart_services.dart';
import 'package:go_super/utils/constants.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final int userId; // Pass the user ID to the cart page

  // ignore: use_key_in_widget_constructors
  const CartPage({Key? key, required this.userId});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  CartService cart = CartService();
  bool _isDisposed = false; // Flag to track if the widget is disposed

  @override
  void dispose() {
    _isDisposed = true; // Set flag to true when the widget is disposed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems(); // Fetch cart items when the page loads
  }

  Future<void> fetchCartItems() async {
  try {
    final response = await http.post(
      Uri.parse('http://34.125.255.35/api/get_cart_items'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'user_id': 'abdelrahman.ameen@ejust.edu.eg'}),
    );

    if (!mounted) {
      return; // Exit if the widget is disposed
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data.containsKey('cart_items')) {
        setState(() {
          cartItems = List<Map<String, dynamic>>.from(data['cart_items']);
        });
      } else {
        print('Cart items not found in response');
      }
    } else {
      print('Failed to fetch cart items');
    }
  } catch (error) {
    if (!mounted) {
      return; // Exit if the widget is disposed
    }
    print('Error: $error');
  }
}


  Future<void> changeQuantity(int productId, int newQuantity) async {
    try {
      final response = await http.post(
        Uri.parse('http://34.125.255.35/api/change_quantity'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_id': 'abdelrahman.ameen@ejust.edu.eg',
          'product_id': productId,
          'quantity': newQuantity,
        }),
      );

      if (response.statusCode == 200) {
        await fetchCartItems();
      } else {
        print('Failed to change quantity');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

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
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          int quantity = item['quantity'] ?? 0;
          int productId = item['product_id'] ?? 0;

          return ListTile(
            title: Text(item['product_name']),
            subtitle: Text('Quantity: $quantity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 0) {
                      changeQuantity(productId, quantity - 1);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    changeQuantity(productId, quantity + 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cart.removefromCart(productId);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Constants.secondaryColor,
        shape: const CircleBorder(eccentricity: 1.0),
        child: Image.asset(
          'images/SUPER GO 3.png',
          height: 55,
          width: 55,
          alignment: Alignment.center,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomNavBar(bottomNavIndex: 2),
    );
  }
}

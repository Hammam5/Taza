import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:go_super/designs/bottomnavbar.dart';
import 'package:go_super/utils/constants.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>> favorites = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('http://34.125.255.35/api/filter'));

      if (response.statusCode == 200) {
        final List<dynamic> products = json.decode(response.body);
        setState(() {
          favorites = List<Map<String, dynamic>>.from(products);
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle errors or show a message
      print('Error fetching products: $e');
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
      body: favorites.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show a loading indicator
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  title: Text(product['productName'] ?? ''),
                  // Display other product details as needed
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
      bottomNavigationBar: const CustomNavBar(bottomNavIndex: 1),
    );
  }
}

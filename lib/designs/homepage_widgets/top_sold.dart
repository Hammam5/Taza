import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_super/services/main_pages_services/cart_services.dart';
import 'package:go_super/utils/circular_prog_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:go_super/utils/constants.dart';

class MostSoldItems extends StatefulWidget {
  const MostSoldItems({Key? key}) : super(key: key);

  @override
  _MostSoldItemsState createState() => _MostSoldItemsState();
}

class _MostSoldItemsState extends State<MostSoldItems> {
  List<Map<String, dynamic>> products = [];
  CartService cart = CartService();
  bool isLoading = true; // Track if data is loading

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://34.125.255.35/api/most_bought_items'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('most_bought_items')) {
          final List<dynamic> apiProducts = responseBody['most_bought_items'];

          setState(() {
            products = List<Map<String, dynamic>>.from(apiProducts);
            isLoading =
                false; // Data loaded successfully, set isLoading to false
          });
        } else {
          throw Exception(
              'Invalid response format: Missing "most_bought_items" key');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Handle error and set isLoading to false
      // ignore: avoid_print
      print('Error fetching products: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.secondaryColor,
      surfaceTintColor: Constants.primaryColor,
      shadowColor: Constants.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Top Sold',
                style: TextStyle(
                  fontFamily: 'Gagalin',
                  color: Constants.tertiaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          isLoading
              ? const Column(
                  children: [
                    SizedBox(height: 30,),
                    Center(
                      child:
                          CustomCircularProgressIndicator(), // Show CircularProgressIndicator while loading
                    ),
                    SizedBox(height: 20,),
                  ],
                )
              : SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          cart.addToCart(product['product_id']);
                        },
                        child: Card(
                          color: Constants.primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                product['name'],
                                style: const TextStyle(
                                  color: Constants.secondaryColor,
                                  fontFamily: 'Gagalin',
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                product['price'],
                                style: const TextStyle(
                                  color: Constants.secondaryColor,
                                  fontFamily: 'Gagalin',
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Image.network(
                                product['product_image'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

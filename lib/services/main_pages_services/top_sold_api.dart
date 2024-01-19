// ignore_for_file: camel_case_types, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<List<topProducts>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1/'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<topProducts> fetchedProducts = responseData.map((data) {
          return topProducts(
            imageUrl: data['imageUrl'],
            productName: data['productName'],
            brandName: data['brandName'],
            price: data['price'].toDouble(),
            boughtLast24hrs: data['boughtLast24hrs'],
            totalBought: data['totalBought'],
            productId: data['product_id']
          );
        }).toList();

        return fetchedProducts;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching data: $error');
    }
  }
}

class topProducts {
  final String imageUrl;
  final String productName;
  final String brandName;
  final double price;
  final int boughtLast24hrs;
  final int totalBought;
  final dynamic productId;

  topProducts({
    required this.imageUrl,
    required this.productName,
    required this.brandName,
    required this.price,
    required this.boughtLast24hrs,
    required this.totalBought, 
    required this.productId,
  });


}

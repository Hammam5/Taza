import 'dart:convert';
import 'package:go_super/models/main_pages_models/ads.dart';
import 'package:http/http.dart' as http;

class AdService {
  Future<List<Ad>> fetchDiscountProd() async {
    const apiUrl = 'http://34.125.255.35/api/expiry_discounts';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('expiry_discounts')) {
          final List<dynamic> adsData = responseData['expiry_discounts'];

          // ignore: unnecessary_type_check
          if (adsData is List) {
            return Ad.parseAdList(adsData.cast<Map<String, dynamic>>());
          }
        }
        throw Exception('Invalid data format: Data is not in the expected format');
      } else {
        throw Exception('Failed to fetch ads: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
  

   Future<List<Ad>> fetchEgyptianProd() async {
    const apiUrl = 'http://34.125.255.35/api/national_products';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('national_products')) {
          final List<dynamic> adsData = responseData['national_products'];

          // ignore: unnecessary_type_check
          if (adsData is List) {
            return Ad.parseAdList(adsData.cast<Map<String, dynamic>>());
          }
        }
        throw Exception('Invalid data format: Data is not in the expected format');
      } else {
        throw Exception('Failed to fetch ads: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
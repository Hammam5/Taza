import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _fetchDataFromAPI(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
                onTap: () {
                  // Handle item tap if needed
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox(); // No suggestions in this implementation
  }

  Future<List<String>> _fetchDataFromAPI(String query) async {
    final response = await http.get(Uri.parse('http://34.125.255.35/api/search?keyword=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('search_results')) {
        final dynamic searchResults = data['search_results'];

        if (searchResults != null && searchResults is List) {
          final List<String> products = searchResults.map((item) {
            return item['name'].toString(); // Assuming 'name' is the key for the product name
          }).toList();
          return products;
        } else {
          throw Exception('Search results data is empty or not in List format');
        }
      } else {
        throw Exception('Search results key not found in the expected format');
      }
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode}');
    }
  }
}

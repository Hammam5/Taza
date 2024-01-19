// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_super/designs/button_design.dart';
import 'package:go_super/designs/textformfields.dart';
import 'package:go_super/utils/constants.dart';
import 'package:http/http.dart' as http;

class FilterSearchBar extends StatefulWidget {
  final void Function(List<Map<String, dynamic>>) onFilterChanged;

  const FilterSearchBar({
    super.key,
    required this.onFilterChanged,
  });

  @override
  _FilterSearchBarState createState() => _FilterSearchBarState();
}

class _FilterSearchBarState extends State<FilterSearchBar> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  String _selectedNationality = '';

  @override
  void dispose() {
    _brandController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.secondaryColor,
      shadowColor: Constants.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextFormField(
                    controller: _brandController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    labelText: 'Brand',
                    hintText: '',
                    prefixIcon: Icons.branding_watermark,
                    ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _minPriceController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    labelText: 'Min Price',
                    hintText: '',
                    prefixIcon: Icons.price_check,
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextFormField(
                    controller: _maxPriceController,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    labelText: 'Max Price',
                    hintText: '',
                    prefixIcon: Icons.price_check,
                    ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              icon: const Icon(Icons.flag_circle),
              iconEnabledColor: Constants.primaryColor,
              iconDisabledColor: Constants.primaryColor,
              iconSize: 25,
              dropdownColor: Constants.secondaryColor,
              style: const TextStyle(fontFamily: 'Gagalin', fontSize: 20, color: Colors.black),
              padding: const EdgeInsets.all(4.0),
              hint: const Text('Nationality', selectionColor: Constants.primaryColor,),
              value:
                  _selectedNationality.isNotEmpty ? _selectedNationality : null,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedNationality = newValue!;
                });
              },
              items: ['Egyptian', 'Foreign',].map((String nationality) {
                return DropdownMenuItem<String>(
                  value: nationality,
                  child: Text(nationality),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  _applyFilters();
                },
                style: ButtonStyles.smallraisedButtonStyle,
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyFilters() async {
    Map<String, String?> filters = {
      'brand': _brandController.text.trim(),
      'min_price': _minPriceController.text.trim(),
      'max_price': _maxPriceController.text.trim(),
      'is_national': _selectedNationality.isNotEmpty
          ? (_selectedNationality == 'Egyptian' ? 'true' : 'false')
          : null,
    };
    String url = 'http://34.125.255.35/api/filter?';
    url += filters.entries
        .where((entry) => entry.value != null && entry.value!.isNotEmpty)
        .map((entry) {
      return '${entry.key}=${Uri.encodeComponent(entry.value!)}';
    }).join('&');

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['filtered_products'] is List) {
          List<dynamic> productList = data['filtered_products'];

          // Convert dynamic list to List<Map<String, dynamic>>
          List<Map<String, dynamic>> mappedProductList =
              productList.cast<Map<String, dynamic>>();

          widget.onFilterChanged(mappedProductList);
        } else {
          print('Invalid data format for filtered products');
        }
      } else {
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

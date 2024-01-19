// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:go_super/models/main_pages_models/product_search.dart';
import '../../designs/homepage_widgets/ads_widget.dart';
import '../../designs/homepage_widgets/top_sold.dart';
import '../../designs/homepage_widgets/search_bar.dart';
import '../../utils/constants.dart';
import 'package:go_super/designs/bottomnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleFilterChanged(List<Map<String, dynamic>> filteredProducts) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtered Products'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text('Product ID: ${product['product_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${product['product_name']}'),
                      Text('Price: \$${product['price']}'),
                    ],
                  ),
                  onTap: () {
                    // Define actions when a product tile is tapped
                    // For instance, navigate to a detailed product page
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secondaryColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch());
              },
              icon: const Icon(Icons.search),
              iconSize: 28,
              color: Constants.secondaryColor,
            ),
          ],
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilterSearchBar(onFilterChanged: _handleFilterChanged),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 340,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            ADS(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    MostSoldItems(),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            backgroundColor: Constants.secondaryColor,
            shape: const CircleBorder(eccentricity: 1.0),
            child: Image.asset('images/SUPER GO 3.png',
                height: 55, width: 55, alignment: Alignment.center)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomNavBar(bottomNavIndex: 0));
  }
}

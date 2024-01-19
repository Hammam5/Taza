import 'package:flutter/material.dart';
import 'package:go_super/designs/cart_buttons/add_to_cart_button.dart';
import 'package:go_super/models/main_pages_models/ads.dart';
import 'package:go_super/utils/constants.dart';

class AdDetailPage extends StatelessWidget {
  final List<Ad> ads;

  const AdDetailPage({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.discount),
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
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (BuildContext context, int index) {
          final Ad currentAd = ads[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                currentAd.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(currentAd.brandName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brand: ${currentAd.brandName}'),
                  Text('Price: \$${double.parse(currentAd.price).toStringAsFixed(2)}'),
                  // Add more details if needed
                ],
              ),
              trailing: AddToCartButton(productId: currentAd.productID),
              onTap: () {
                _navigateToAdDetails(currentAd, context);
              },
            ),
          );
        },
      ),
    );
  }

  void _navigateToAdDetails(Ad ad, BuildContext context) {
    // You can navigate to a detailed view of the selected ad here
    // For example:
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdDetailsScreen(ad: ad)));
    // This would navigate to a new screen showing the details of the selected ad
  }
}

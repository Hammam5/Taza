import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_super/services/main_pages_services/ads_services.dart';

class ADS extends StatefulWidget {
  const ADS({Key? key}) : super(key: key);

  @override
  _ADSState createState() => _ADSState();
}

class _ADSState extends State<ADS> {
  final AdService adService = AdService();
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    // Start the timer to change the page every 4 seconds
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the page controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 500,
      child: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          GestureDetector(
            onTap: () {
              adService.fetchDiscountProd();
            },
            child: Image.asset('images/discount.png', height: 300, width: 500),
          ),
          GestureDetector(
            onTap: () {
              adService.fetchEgyptianProd();
            },
            child: Image.asset('images/Egypt.png', height: 300, width: 500),
          ),
        ],
      ),
    );
  }
}

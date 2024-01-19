import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_super/pages/home_page/cart_page.dart';
import 'package:go_super/pages/home_page/favourites.dart';
import 'package:go_super/pages/home_page/home_page.dart';
import 'package:go_super/pages/home_page/settings.dart';
import 'package:go_super/utils/constants.dart';

class CustomNavBar extends StatefulWidget {
  final int bottomNavIndex;

  const CustomNavBar({super.key, required this.bottomNavIndex});

  @override
  // ignore: no_logic_in_create_state
  State<CustomNavBar> createState() => _CustomNavBarState(bottomNavIndex);
}

class _CustomNavBarState extends State<CustomNavBar> {
  int bottomNavIndex;

  _CustomNavBarState(this.bottomNavIndex);

  final iconList = [
    Icons.home,
    Icons.shopping_bag_outlined,
    Icons.shopping_cart_outlined,
    Icons.settings,
  ];

  void _onItemTapped(int index) {
    setState(() {
      bottomNavIndex = index;
      if (bottomNavIndex == 0) {
        Get.off(const HomePage());
      } else if (bottomNavIndex == 1) {
        Get.off(const ProductsPage());
      } else if (bottomNavIndex == 2) {
        Get.off(const CartPage(userId: 1));
      }
      if (bottomNavIndex == 3) {
        Get.off(const SettingsPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconList,
      activeIndex: bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: _onItemTapped,
      backgroundColor: Constants.primaryColor,
      inactiveColor: Constants.secondaryColor,
      activeColor: Constants.tertiaryColor,
      iconSize: 28,
    );
  }
}

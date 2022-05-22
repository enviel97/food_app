import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/views/history/history.page.dart';
import 'package:food_shop/views/home/home.page.dart';
import 'package:food_shop/views/personal/personal.page.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'cart/controllers/cart.controller.dart';
import 'widgets/bottom_navigator.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final Iterable<KBottomNavigationProps> _items = [
    KBottomNavigationProps(
      'Home',
      Icons.home_rounded,
      const Home(),
    ),
    KBottomNavigationProps(
      'History',
      Icons.archive_rounded,
      const History(),
    ),
    KBottomNavigationProps(
      'Me',
      Icons.person_rounded,
      const Personal(),
    ),
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CartController>(
            builder: (controller) => _items.elementAt(_currentPage).view),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _cartButton,
        bottomNavigationBar: KBottomAppBar(
            currentIndex: _currentPage,
            items: _items.map((prop) => prop.toView),
            onChangePage: (int? index) {
              setState(() {
                _currentPage = index ?? 1;
              });
            }));
  }

  Widget get _cartButton {
    return GetBuilder<CartController>(builder: (controller) {
      return FloatingActionButton(
        child: LayoutBuilder(builder: (_, constraints) {
          final h = constraints.biggest.height;
          final w = constraints.biggest.width;
          return Badge(
            position: BadgePosition.topEnd(top: -h / 3, end: -w / 3),
            showBadge: !controller.isEmpty,
            badgeContent: Text(
              '${controller.size}',
              style: const TextStyle(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Icon(Icons.shopping_cart_checkout_outlined),
          );
        }),
        onPressed: () {
          if (!controller.isEmpty) {
            RouteHelper.goTo(RouteId.getCart());
            return;
          }
          if (!Get.isSnackbarOpen) {
            Get.snackbar('Notice', "Don't have any item in cart");
          }
        },
      );
    });
  }
}

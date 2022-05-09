import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/home/controllers/cart.controller.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:food_shop/views/home/widgets/cart_button.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';
import 'package:get/get.dart';

import 'ui/food_banner.dart';
import 'ui/food_popular.dart';
import 'ui/header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentPage = 0;
  final Duration _duration = const Duration(milliseconds: 500);
  late PageController _controller;
  late AnimationController _iconController;

  @override
  void initState() {
    _controller = PageController(initialPage: _currentPage);
    _iconController = AnimationController(duration: _duration, vsync: this);
    super.initState();
    Future.wait([
      Get.find<PopularFoodConroller>().getPopularFoodList(),
      Get.find<RecommendedFoodConroller>().getRecommendedFoodList(),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _iconController.dispose();
    Get.find<RecommendedFoodConroller>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        onChangedPage: _onPressed,
        pageIndex: _currentPage,
        iconController: _iconController,
      ),
      body: GetBuilder<CartController>(
        builder: (CartController controller) {
          return PageView(
            scrollDirection: Axis.vertical,
            scrollBehavior: RemoveGrow(),
            controller: _controller,
            onPageChanged: _onPageChange,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: const FoodBanner(),
              ),
              const FoodPopular(),
            ],
          );
        },
      ),
      floatingActionButton: _cartButton,
    );
  }

  Widget get _cartButton {
    return GetBuilder<CartController>(builder: (controller) {
      return CartButton(
        backgroundColor: kSecondaryColor,
        size: Spacing.xxxl,
        isShowBadge: !controller.isEmpty,
        quantity: controller.size,
        onPressed: () {
          if (!controller.isEmpty) {
            RouteHelper.goTo(RouteId.cart);
          }
        },
      );
    });
  }

  void _onPressed() {
    if (_currentPage == 0) {
      _controller.nextPage(
        duration: _duration,
        curve: Curves.easeInOut,
      );
    } else {
      _controller.previousPage(
        duration: _duration,
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChange(int pageIndex) {
    _currentPage = pageIndex;
    if (_iconController.isCompleted) {
      _iconController.reverse();
    } else {
      _iconController.forward();
    }
  }
}

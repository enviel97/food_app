import 'package:flutter/material.dart';
import 'package:food_shop/src/home/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/lists/custom_single_child_scrollview.dart';

import 'ui/food_popular.dart';
import 'ui/header.dart';
import 'ui/food_banner.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: KSingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: HomeDimensions.kFoodBanner,
              child: const FoodBanner(),
            ),
            Spacing.vertical.xl,
            SizedBox(
              height: HomeDimensions.kFoodPopular,
              child: const FoodPopular(),
            ),
          ],
        ),
      ),
    );
  }
}

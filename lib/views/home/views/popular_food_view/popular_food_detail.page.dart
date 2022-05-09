import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/body.dart';
import 'ui/bottom_navigation.dart';
import 'ui/header.dart';

class PopularFoodDetail extends StatelessWidget {
  final String foodId;
  const PopularFoodDetail({
    required this.foodId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PopularFoodConroller>(
        builder: (controller) {
          final food = controller.getPopularFood(foodId);
          if (food == null) {
            return const Center(child: HeaderText('Error on get food'));
          }
          return Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: CachedNetworkImageProvider(food.images.first,
                    maxHeight: (Dimensions.kHeight * 0.5).h.toInt()),
                fit: BoxFit.none,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Header(),
                  Body(food: food),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          GetBuilder<PopularFoodConroller>(builder: (controller) {
        final food = controller.getPopularFood(foodId);
        return PurchaseHandlerBottom(food: food);
      }),
    );
  }
}

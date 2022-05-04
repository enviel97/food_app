import 'package:flutter/material.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/body.dart';
import 'ui/bottom_navigate.dart';
import 'ui/header.dart';

class RecommenedFoodDetail extends StatelessWidget {
  final String foodId;
  const RecommenedFoodDetail({
    required this.foodId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final food =
        Get.find<RecommendedFoodConroller>().getRecommendedFodd(foodId);

    return Scaffold(
      body: (food == null)
          ? const Center(child: HeaderText('Error on get food'))
          : CustomScrollView(
              scrollBehavior: RemoveGrow(),
              slivers: [
                Header(
                  imageFood: food.images[0],
                  nameFood: food.name,
                ),
                Body(
                  decription: food.description,
                  price: food.price,
                  rating: food.finalRate,
                  comments: food.comments,
                ),
              ],
            ),
      bottomNavigationBar: food != null
          ? RecommendFoodPurchase(
              id: foodId,
              price: food.price,
              name: food.name,
            )
          : null,
    );
  }
}

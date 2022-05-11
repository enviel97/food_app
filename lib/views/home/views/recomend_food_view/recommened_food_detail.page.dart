import 'package:flutter/material.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:food_shop/views/home/views/ui/error_load.dart';
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
    return Scaffold(
      body: GetBuilder<RecommendedFoodConroller>(
        builder: (controller) {
          final food = controller.getRecommendedFodd(foodId);
          if (food == null) {
            return const ErrorLoad();
          }
          return CustomScrollView(
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
          );
        },
      ),
      bottomNavigationBar: GetBuilder<RecommendedFoodConroller>(
        builder: (controller) {
          return RecommendFoodPurchase(
            food: controller.getRecommendedFodd(foodId),
          );
        },
      ),
    );
  }
}

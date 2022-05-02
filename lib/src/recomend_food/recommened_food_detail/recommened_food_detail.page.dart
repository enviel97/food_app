import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';

import 'ui/body.dart';
import 'ui/bottom_navigate.dart';
import 'ui/header.dart';

class RecommenedFoodDetail extends StatelessWidget {
  final Food food;
  const RecommenedFoodDetail({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
      bottomNavigationBar: RecommendFoodPurchase(
        id: '@foodId',
        price: food.price,
        name: food.name,
      ),
    );
  }
}

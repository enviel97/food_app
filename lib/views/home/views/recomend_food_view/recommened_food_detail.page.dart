import 'package:flutter/material.dart';
import 'package:food_shop/views/home/controllers/recommended_food.controller.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/body.dart';
import 'ui/bottom_navigate.dart';
import 'ui/header.dart';

class RecommenedFoodDetail extends StatefulWidget {
  final String foodId;
  const RecommenedFoodDetail({
    required this.foodId,
    Key? key,
  }) : super(key: key);

  @override
  State<RecommenedFoodDetail> createState() => _RecommenedFoodDetailState();
}

class _RecommenedFoodDetailState extends State<RecommenedFoodDetail> {
  final controller = Get.find<RecommendedFoodConroller>();

  @override
  void initState() {
    super.initState();
    controller.getRecommendedFodd(widget.foodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final food = controller.selectedFood;
        final status = controller.status(recommendedFoodId);
        if (food != null) {
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
        }

        return Center(
            child: status.isError
                ? const HeaderText('Error loading food')
                : const CircularProgressIndicator());
      }),
      bottomNavigationBar:
          Obx(() => RecommendFoodPurchase(food: controller.selectedFood)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/home/dependencies/popular_product/recommended_food.controller.dart';
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
  Food? food;

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    food = await Get.find<RecommendedFoodConroller>()
        .getRecommendedFood(widget.foodId);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RecommendedFoodConroller>(builder: (controller) {
        if (food != null) {
          return CustomScrollView(
            scrollBehavior: RemoveGrow(),
            slivers: [
              Header(
                imageFood: food!.images.first,
                nameFood: food!.name,
              ),
              Body(
                decription: food!.description,
                price: food!.price,
                rating: food!.finalRate,
                comments: food!.comments,
              ),
            ],
          );
        }

        return Center(
            child: controller.isError
                ? const HeaderText('Error loading food')
                : const CircularProgressIndicator());
      }),
      bottomNavigationBar: RecommendFoodPurchase(food: food),
    );
  }
}

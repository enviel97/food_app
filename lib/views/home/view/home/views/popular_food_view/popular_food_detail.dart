import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    final food = Get.find<PopularFoodConroller>().getPopularFood(foodId);

    return Scaffold(
      body: food == null
          ? const Center(child: HeaderText('Error on get food'))
          : Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: CachedNetworkImageProvider(food.images.first),
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
            ),
      bottomNavigationBar: PurchaseHandlerBottom(
        onGetQuantity: (int quantity) {
          print('${food?.name}: $quantity x ${food?.price}');
        },
      ),
    );
  }
}

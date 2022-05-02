import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';

import 'ui/bottom_navigation.dart';
import 'ui/body.dart';
import 'ui/header.dart';

class PopularFoodDetail extends StatelessWidget {
  final Food food;
  const PopularFoodDetail({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          print('${food.name}: $quantity x ${food.price}');
        },
      ),
    );
  }
}

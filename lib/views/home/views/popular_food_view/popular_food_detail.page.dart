import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/food.dart';

import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/body.dart';
import 'ui/bottom_navigation.dart';
import 'ui/header.dart';

class PopularFoodDetail extends StatefulWidget {
  final String foodId;
  const PopularFoodDetail({
    required this.foodId,
    Key? key,
  }) : super(key: key);

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  Food? food;

  @override
  void initState() {
    super.initState();
    _fetchFood();
  }

  Future<void> _fetchFood() async {
    food = await Get.find<PopularFoodConroller>().getPopularFood(widget.foodId);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Header(),
        body: GetBuilder<PopularFoodConroller>(builder: (controller) {
          if (food != null) {
            return Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: CachedNetworkImageProvider(
                    food!.images.last,
                    maxHeight: (Dimensions.kHeight * 0.75).h.toInt(),
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Body(food: food!),
            );
          }

          return Center(
              child: controller.isError
                  ? const HeaderText('Error loading food')
                  : const CircularProgressIndicator());
        }),
        bottomNavigationBar: PurchaseHandlerBottom(food: food));
  }
}

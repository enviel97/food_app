import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/controllers/cart.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

import '../widgets/favorite_button.dart';
import '../widgets/quantity_price.dart';

class RecommendFoodPurchase extends StatelessWidget {
  final Food? food;
  const RecommendFoodPurchase({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24.0)),
            color: kPlaceholderSuperDarkColor.withOpacity(.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: HomeDimensions.kPopularFoodPurchase,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FavoriteButton(foodId: '@user', isFavorite: false),
              Spacing.horizantal.xxxl,
              Expanded(
                child: KTextButton(
                  'Add to cart $kCartSymbol',
                  textColor: kWhiteColor,
                  disabled: (food?.name.isEmpty ?? false) ||
                      (food?.price ?? -1.0).isNegative,
                  onPressed: () => _showAddCartModel(context),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _showAddCartModel(BuildContext context) async {
    if (food == null) return;
    final quantity = await Get.bottomSheet<int?>(
      QuantityPrice(name: food!.name, price: food!.price),
      backgroundColor: kLightBackgoundColor,
      enableDrag: true,
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
    );
    if (quantity == null) return;
    if (quantity == 0) {
      await Get.find<CartController>().removeItem(food!.id, food!.name);
      return;
    }

    await Get.find<CartController>().addItem(food!, quantity: quantity);
  }
}

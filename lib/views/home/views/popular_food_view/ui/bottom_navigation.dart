import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/home/controllers/cart.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/quantity_numberic.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

class PurchaseHandlerBottom extends StatelessWidget {
  final Food? food;
  const PurchaseHandlerBottom({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        color: kPlaceholderSuperDarkColor.withOpacity(.07),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: HomeDimensions.kPopularFoodPurchase,
      child: GetBuilder<CartController>(
        builder: (controller) {
          final quantityController = QuantityNumbericController(
            initQuanity: controller.getFoodById(food?.id ?? '')?.quantity ?? 1,
          );
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: QuantityNumberic(controller: quantityController),
              ),
              Spacing.horizantal.xxxl,
              Expanded(
                child: KTextButton(
                  'Add to cart $kCartSymbol',
                  textColor: kWhiteColor,
                  disabled: food == null,
                  onPressed: () {
                    final quantity = quantityController.quantity;
                    if (quantity != 0) {
                      controller.changeQuantity(food!, quantity: quantity);
                      return;
                    }
                    controller.removeItem(food!.id, food!.name);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

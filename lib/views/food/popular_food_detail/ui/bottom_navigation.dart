import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/food/popular_food_detail/widgets/quantity_numberic.dart';
import 'package:food_shop/views/food/styles/dimensions.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class PurchaseHandlerBottom extends StatelessWidget {
  final void Function(int quantity) onGetQuantity;
  const PurchaseHandlerBottom({required this.onGetQuantity, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = QuantityNumbericController();
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        color: kPlaceholderSuperDarkColor.withOpacity(.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: FoodDimensions.kPopularFoodPurchase,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: QuantityNumberic(controller: controller)),
          Spacing.horizantal.xxxl,
          Expanded(
            child: KTextButton(
              'Add to cart $kCartSymbol',
              textColor: kWhiteColor,
              onPressed: () => onGetQuantity(controller.quantiyy),
            ),
          )
        ],
      ),
    );
  }
}

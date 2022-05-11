import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/cart/controllers/cart.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/quantity_numberic.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

class PurchaseHandlerBottom extends StatefulWidget {
  final Food? food;
  const PurchaseHandlerBottom({
    required this.food,
    Key? key,
  }) : super(key: key);

  @override
  State<PurchaseHandlerBottom> createState() => _PurchaseHandlerBottomState();
}

class _PurchaseHandlerBottomState extends State<PurchaseHandlerBottom> {
  final quantityController = QuantityNumbericController(initQuanity: 1);

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
          final food = controller.getFoodById(widget.food?.id ?? '');

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: QuantityNumberic(
                  controller: quantityController,
                  initQuantity: food?.quantity ?? 1,
                ),
              ),
              Spacing.horizantal.xxxl,
              Expanded(
                child: KTextButton(
                  'Add to cart $kCartSymbol',
                  textColor: kWhiteColor,
                  disabled: widget.food == null,
                  onPressed: () {
                    final quantity = quantityController.quantity;
                    if (quantity != 0) {
                      controller.addToCart(
                        widget.food!,
                        quantity: quantity,
                        pageId: RouteId.getPopularFood(widget.food!.id),
                      );
                      return;
                    }
                    controller
                        .removeItem(widget.food!.id, widget.food!.name)
                        .then(
                      (isConfrim) {
                        if (isConfrim) {
                          quantityController.setQuantity(value: 1);
                        }
                      },
                    );
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

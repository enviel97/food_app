import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/quantity_numberic.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class FoodInCartItem extends StatelessWidget {
  final FoodInCart food;
  final bool disableAction;
  final void Function(int quantity) onQuanityChange;
  final void Function() removeItem;

  const FoodInCartItem({
    required this.onQuanityChange,
    required this.food,
    required this.removeItem,
    Key? key,
    this.disableAction = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = 10.0.h;

    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(.5),
            blurRadius: 10.0,
            offset: const Offset(5, 7),
          ),
        ],
      ),
      height: Dimensions.kHeight100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LazzyImages(
            food.image,
            width: Dimensions.kHeight100,
            height: Dimensions.kHeight100,
            radius: radius,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xs,
                vertical: 5.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: BodyText(
                            food.name,
                            maxLines: 1,
                            fontSize: Spacing.m,
                            textOverflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                      ),
                      KIconButton(
                        icon: Icons.remove_shopping_cart_rounded,
                        backgroundColor: kPlaceholderColor,
                        disable: disableAction,
                        size: Spacing.lg,
                        onPressed: removeItem,
                      ),
                    ],
                  ),
                  BodyText(
                    food.options,
                    maxLines: 1,
                    color: kPlaceholderDarkColor,
                    fontSize: Spacing.s,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyText(
                          '${food.price} \$',
                          fontSize: Spacing.lg * 0.8,
                          fontWeight: FontWeight.bold,
                          color: kErrorColor,
                        ),
                        QuantityNumberic(
                          initQuantity: food.quantity,
                          disableAction: disableAction,
                          onChanged: onQuanityChange,
                          minQuantity: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/views/home/widgets/quantity_numberic.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class FoodInCartItem extends StatelessWidget {
  final FoodInCart food;
  final void Function(int quantity) onQuanityChange;

  const FoodInCartItem({
    required this.onQuanityChange,
    required this.food,
    Key? key,
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
      height: HomeDimensions.kHeader100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LazzyImages(
            food.image,
            width: HomeDimensions.kHeader100,
            height: HomeDimensions.kHeader100,
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
                  BodyText(
                    food.name,
                    maxLines: 1,
                    fontSize: Spacing.m,
                    textOverflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  BodyText(
                    food.name,
                    maxLines: 1,
                    color: kPlaceholderDarkColor,
                    fontSize: Spacing.s,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  Expanded(
                    // color: kErrorColor,
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

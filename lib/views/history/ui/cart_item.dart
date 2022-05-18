import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_shop/extentions/data_time.extension.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/history/controllers/history.controller.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  final Cart data;
  const CartItem({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = min(data.foods.length, 3);
    final diff = data.foods.length - 3;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      margin: EdgeInsets.only(bottom: 15.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0.h),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(.2),
            blurRadius: 2.5,
            offset: const Offset(5, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  GetBuilder<HistoryController>(
                    builder: (controller) => KIconButton(
                      backgroundColor: kWhiteColor,
                      icon: Icons.highlight_remove_rounded,
                      iconColor: kErrorColor,
                      size: Spacing.m,
                      iconScale: 1.0,
                      onPressed: () {
                        controller.removeCart(data.id);
                      },
                    ),
                  ),
                  Spacing.horizantal.xs,
                  Text(data.createDate!.toNormal),
                ]),
                Spacing.vertical.xs,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < size; ++i) ...[
                      _buildImage(i: i, diff: diff),
                      Spacing.horizantal.xs,
                    ]
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BodyText('Total', fontSize: Spacing.s),
              BodyText(
                '${data.foods.length} items',
                fontSize: Spacing.m,
                fontWeight: FontWeight.w900,
              ),
              KTextButton(
                'Show more',
                isOutline: true,
                onPressed: () {
                  RouteHelper.goTo(RouteId.getCart(cartId: data.id));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage({required int i, required int diff}) {
    return SizedBox(
      height: (Dimensions.kHeader100 * .65).h,
      width: (Dimensions.kHeader100 * .65).h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LazzyImages(data.foods[i].image, radius: 15.0.h),
          if (diff < 0 && i == 2)
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0.h),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: kPlaceholderColor.withOpacity(0.5),
                  ),
                  child: Center(child: BodyText('+$diff')),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart' as modal;
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/controllers/cart.controller.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/bottom.dart';
import 'ui/food_in_cart_item.dart';
import 'ui/header.dart';

class Cart extends StatelessWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 45.0, top: 25.0),
            child: HeaderText(
              'Cart',
              fontSize: Spacing.xl,
              fontWeight: FontWeight.w500,
              color: kBlackColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(color: kPlaceholderDarkColor),
          ),
          Expanded(
            child: GetBuilder<CartController>(builder: (controller) {
              return KListView<modal.FoodInCart>(
                datas: controller.getFoods(),
                itemBuilder: (data, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FoodInCartItem(
                      food: data,
                      onQuanityChange: (quantity) {},
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Bottom(totalPrice: controller.totalPrice);
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/cart/controllers/cart.controller.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/bottom.dart';
import 'ui/food_in_cart_item.dart';

class Cart extends StatelessWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  Widget _buildActionButton({
    required IconData icon,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: KIconButton(
        icon: icon,
        size: Spacing.xxl,
        backgroundColor: kSecondaryColor,
        iconColor: kWhiteColor,
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: KBackButton(backgroundColor: kPrimaryColor),
        ),
        centerTitle: false,
        title: const HeaderText(
          'Cart',
          fontSize: Spacing.xl,
          fontWeight: FontWeight.w500,
          color: kBlackColor,
        ),
        actions: [
          _buildActionButton(
            icon: Icons.home,
            onPressed: () {
              RouteHelper.goTo(RouteId.getMain());
            },
          ),
          _buildActionButton(
            icon: Icons.payment_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        return KListView<FoodInCart>(
          datas: controller.getFoods,
          itemBuilder: (data, _) {
            return GestureDetector(
              onTap: () => _onOpenDetail(data),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FoodInCartItem(
                  food: data,
                  onQuanityChange: (quantity) {
                    controller.changeQuantityById(
                      data.id,
                      quantity: quantity,
                    );
                  },
                  removeItem: () {
                    controller.removeItem(data.id, data.name);
                  },
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return Bottom(totalPrice: controller.totalPrice);
      }),
    );
  }

  _onOpenDetail(FoodInCart data) {
    RouteHelper.goTo(data.pageId);
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/routes/routes.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/cart/dependencies/cart.controller.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

import 'ui/bottom.dart';
import 'ui/food_in_cart_item.dart';

class Cart extends StatelessWidget {
  final String? cartId;
  const Cart({
    Key? key,
    this.cartId,
  }) : super(key: key);

  Widget _buildActionButton(
    IconData icon, {
    required Function() onPressed,
    bool disable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: KIconButton(
        icon: icon,
        size: Spacing.xxl,
        backgroundColor: kSecondaryColor,
        iconColor: kWhiteColor,
        onPressed: onPressed,
        disable: disable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      body: GetBuilder<CartController>(builder: (controller) {
        final datas = controller.getFoods(cartId: cartId);

        return KListView<FoodInCart>(
          datas: datas,
          itemBuilder: (data, _) {
            return GestureDetector(
              onTap: () => _onOpenDetail(data),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FoodInCartItem(
                  food: data,
                  disableAction: cartId != null,
                  onQuanityChange: (quantity) {
                    controller.changeQuantityById(data.id, quantity: quantity);
                  },
                  removeItem: () {
                    controller.removeItem(data.id);
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

  void _onOpenDetail(FoodInCart data) {
    RouteHelper.goTo(data.pageId);
  }

  AppBar _buildHeader() {
    return AppBar(
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
          Icons.home,
          onPressed: () {
            RouteHelper.replace(RouteId.getMain());
          },
        ),
        GetBuilder<CartController>(builder: (controller) {
          final foods = controller.getFoods(cartId: cartId);
          return _buildActionButton(
            Icons.payment_rounded,
            disable: foods.isEmpty,
            onPressed: () async {
              final confirm = await controller.payment(foods);
              if (confirm) {
                RouteHelper.replace(RouteId.getMain());
              }
            },
          );
        }),
      ],
    );
  }
}

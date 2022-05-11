import 'package:flutter/material.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/cart/controllers/cart.controller.dart';
import 'package:food_shop/views/home/widgets/cart_button.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const KBackButton(),
          GetBuilder<CartController>(
            builder: (CartController controller) {
              if (Get.previousRoute == RouteId.getCart()) {
                return const SizedBox.shrink();
              }
              return CartButton(
                isShowBadge: !controller.isEmpty,
                quantity: controller.size,
                onPressed: () {
                  RouteHelper.goTo(RouteId.getCart());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

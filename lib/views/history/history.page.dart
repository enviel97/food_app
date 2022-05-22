import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/views/auth/controllers/auth.controller.dart';
import 'package:food_shop/views/history/controllers/history.controller.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/page/empty.page.dart';
import 'package:get/get.dart';

import 'ui/cart_item.dart';
import 'ui/header.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    Get.find<HistoryController>().getHistoryCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: GetBuilder<HistoryController>(builder: (controller) {
        return KListView<Cart>(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          datas: controller.carts,
          itemBuilder: (data, _) => _itemBuilder(data),
          emptyBuilder: _buildEmptyBuilder,
        );
      }),
    );
  }

  Widget _itemBuilder(Cart data) {
    return CartItem(data: data);
  }

  Widget _buildEmptyBuilder() {
    return GetBuilder<AuthController>(builder: (controller) {
      final message = controller.user == null
          ? 'Please sign in to use this feature'
          : "You don't have any history cart";
      return Empty(title: message);
    });
  }
}

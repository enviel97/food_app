import 'package:flutter/material.dart';
import 'package:food_shop/models/cart.dart';
import 'package:food_shop/views/history/controllers/history.controller.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
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
        );
      }),
    );
  }

  Widget _itemBuilder(Cart data) {
    return CartItem(data: data);
  }
}

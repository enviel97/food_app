import 'package:flutter/material.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

import '../widgets/favorite_button.dart';
import '../widgets/quantity_price.dart';

class RecommendFoodPurchase extends StatelessWidget {
  final String id;
  final String? name;
  final double? price;
  const RecommendFoodPurchase({
    required this.id,
    this.price,
    this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24.0)),
            color: kPlaceholderSuperDarkColor.withOpacity(.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: HomeDimensions.kPopularFoodPurchase,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FavoriteButton(foodId: '@user', isFavorite: false),
              Spacing.horizantal.xxxl,
              Expanded(
                child: KTextButton(
                  'Add to cart $kCartSymbol',
                  textColor: kWhiteColor,
                  disabled: price == null || (name?.isEmpty ?? true),
                  onPressed: () => _showAddCartModel(context),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _showAddCartModel(BuildContext context) async {
    final quantity = await showModalBottomSheet<int?>(
      context: context,
      backgroundColor: kLightBackgoundColor,
      enableDrag: true,
      elevation: 10.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (_) => QuantityPrice(name: name!, price: price!),
    );
    if (quantity != null) {
      print(quantity);
    }
  }
}

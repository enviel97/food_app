import 'package:flutter/material.dart';
import 'package:food_shop/src/recomend_food/recommened_food_detail/widgets/favorite_button.dart';
import 'package:food_shop/src/recomend_food/recommened_food_detail/widgets/quantity_price.dart';
import 'package:food_shop/src/recomend_food/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class RecommendFoodPurchase extends StatelessWidget {
  final String id, name;
  final double price;
  const RecommendFoodPurchase({
    required this.id,
    required this.price,
    required this.name,
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
          height: RecommendFoodDimensions.kPopularFoodPurchase,
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
      builder: (_) => QuantityPrice(name: name, price: price),
    );

    print(quantity);
  }
}
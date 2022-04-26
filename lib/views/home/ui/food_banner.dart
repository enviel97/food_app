import 'package:flutter/material.dart' hide Slider;
import 'package:food_shop/models/food.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/widgets/notice.dart';
import 'package:food_shop/views/home/widgets/slider.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/texts/custom_text.dart';
import 'package:star_rating/star_rating.dart';

class FoodBanner extends StatelessWidget {
  const FoodBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      automation: false,
      data: List.generate(5, (index) => Food.faker()),
      itemBuilder: (Food item) => LayoutBuilder(
        builder: (context, constrain) {
          final height = constrain.maxHeight;
          const radius = 25.0;
          final iconColor = item.status == FoodStatus.empty
              ? kErrorColor
              : item.status == FoodStatus.little
                  ? kWarningColor
                  : kSuccessColor;

          return Container(
            margin: const EdgeInsets.only(bottom: 35.0),
            child: Stack(
              children: [
                LazzyImages(item.banner, radius: radius, height: height * .75),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * .36,
                    margin: const EdgeInsets.only(right: 25.0, left: 25.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 12.0,
                    ),
                    decoration: const BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 5.0),
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BodyText(
                          item.name,
                          fontSize: Spacing.m,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StarRating(
                              length: 5,
                              rating: item.finalRate,
                              color: kPrimaryDarkColor,
                            ),
                            Spacing.horizantal.xs,
                            BodyText(
                              item.finalRate.toStringAsFixed(2),
                              fontSize: Spacing.s,
                              fontWeight: FontWeight.bold,
                              color: kPlaceholderDarkColor,
                            ),
                            Spacing.horizantal.xs,
                            BodyText(
                              '${item.comments.length} cmts',
                              fontSize: Spacing.s,
                              fontWeight: FontWeight.bold,
                              color: kPlaceholderDarkColor,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Notice(
                                explain: item.status.name,
                                icon: Icons.circle,
                                iconColor: iconColor),
                            Notice(
                              explain: '~ ${item.timePrepare} mins',
                              icon: Icons.timer_outlined,
                              iconColor: kSecondaryDarkColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart' hide Slider;
import 'package:food_shop/models/food.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/home/controllers/popular_product.controller.dart';
import 'package:food_shop/views/home/view/home/widgets/food_infomation.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/lists/slider.dart';
import 'package:food_shop/widgets/images/lazy_images.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';
import 'package:star_rating/star_rating.dart';

class FoodBanner extends StatefulWidget {
  const FoodBanner({Key? key}) : super(key: key);

  @override
  State<FoodBanner> createState() => _FoodBannerState();
}

class _FoodBannerState extends State<FoodBanner> {
  @override
  void initState() {
    super.initState();
    Get.find<PopularFoodConroller>().getPopularFoodList();
  }

  BoxDecoration get _decoration {
    return const BoxDecoration(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularFoodConroller>(
      builder: (controller) {
        if (!controller.isLoaded && !controller.isError) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.isError) {
          return const Center(
            child: HeaderText('Service error'),
          );
        }
        return Slider(
          automation: false,
          data: controller.popularFoodList,
          itemBuilder: _itemBuilder,
          paddingImage: const EdgeInsets.only(bottom: 20.0),
        );
      },
    );
  }

  Widget _itemBuilder(Food item) {
    return LayoutBuilder(
      builder: (context, constrain) {
        final height = constrain.maxHeight;
        return GestureDetector(
          onTap: () => Get.toNamed(RouteHelper.getPopularFood(item.id)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Stack(
              children: [
                LazzyImages(item.banner, radius: 25.0, height: height * .85),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: _decoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BodyText(item.name, maxLines: 1, fontSize: Spacing.m),
                        Spacing.vertical.xs,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StarRating(
                              length: 5,
                              rating: item.finalRate,
                              color: kPrimaryDarkColor,
                            ),
                            BodyText(
                              '${item.finalRate.toStringAsFixed(2)} ~'
                              ' ${item.comments.length} cmts',
                              fontSize: Spacing.s,
                              fontWeight: FontWeight.bold,
                              color: kPlaceholderDarkColor,
                            ),
                          ],
                        ),
                        Spacing.vertical.xs,
                        FoodInfomation(
                          status: item.status,
                          timePrepare: '${item.timePrepare}',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

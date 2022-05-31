import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/routes/routes.dart';
import 'package:food_shop/views/cart/dependencies/cart.controller.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/views/home/widgets/cart_button.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/texts/bordered_text.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class Header extends StatefulWidget {
  final String imageFood, nameFood;
  const Header({
    required this.imageFood,
    required this.nameFood,
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final key = UniqueKey();
  Color backgroundColor = kPrimaryLightColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(_precacheImage);
    _updatePalete();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: HomeDimensions.kRecommendFoodAppBarExpanded,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: KBackButton(),
      ),
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<CartController>(
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
        ),
      ],
      backgroundColor: backgroundColor,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25.0),
        ),
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.none,
        background: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.imageFood),
              fit: BoxFit.cover,
            ),
          ),
        ),
        expandedTitleScale: 1.2,
        title: BorderedText(widget.nameFood),
      ),
    );
  }

  void _updatePalete() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(widget.imageFood, cacheKey: key.toString()),
      size: const Size(100, 200),
    );
    final paletteColor =
        generator.dominantColor ?? PaletteColor(kPrimaryColor, 2);
    backgroundColor = paletteColor.color;
    if (mounted) setState(() => {});
  }

  Future<void> _precacheImage(Duration timeStamp) async {
    await precacheImage(
      CachedNetworkImageProvider(widget.imageFood, cacheKey: key.toString()),
      context,
    );
  }
}

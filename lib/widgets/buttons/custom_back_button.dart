import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';

class KBackButton<T> extends StatelessWidget {
  final bool Function()? onGoBack;
  final double size;
  final T? agruments;
  final Color? backgroundColor, iconColor;
  const KBackButton({
    Key? key,
    this.onGoBack,
    this.size = Spacing.xxl,
    this.agruments,
    this.backgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KIconButton(
      size: size.h,
      icon: Icons.arrow_back_ios_rounded,
      iconColor: iconColor ?? kBlackColor,
      backgroundColor: backgroundColor ?? kWhiteColor.withOpacity(0.6),
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    // have prevent
    if (onGoBack != null && onGoBack!()) {
      RouteHelper.goBack(result: agruments);
    }
    if (onGoBack == null) {
      RouteHelper.goBack(result: agruments);
    }
  }
}

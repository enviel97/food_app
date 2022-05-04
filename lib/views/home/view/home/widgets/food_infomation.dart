import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/widgets/decorations/notice.dart';

class FoodInfomation extends StatelessWidget {
  final FoodStatus status;
  final String timePrepare;

  const FoodInfomation({
    required this.status,
    required this.timePrepare,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = status == FoodStatus.empty
        ? kErrorColor
        : status == FoodStatus.little
            ? kWarningColor
            : kSuccessColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Notice(
          explain: status.name,
          icon: Icons.circle,
          iconColor: iconColor,
        ),
        Notice(
          explain: '~ $timePrepare mins',
          icon: Icons.timer_outlined,
          iconColor: kSecondaryDarkColor,
        )
      ],
    );
  }
}

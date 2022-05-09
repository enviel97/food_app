import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/home/styles/dimensions.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class Bottom extends StatelessWidget {
  final double totalPrice;
  const Bottom({
    required this.totalPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HomeDimensions.kHeader100,
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
        color: kPlaceholderDarkColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderText(
            'Total:',
            color: kBlackColor,
          ),
          BorderedText(
            strokeColor: kBlackColor,
            strokeWidth: 5.0,
            child: Text(
              '$totalPrice \$',
              style: const TextStyle(
                color: kWhiteColor,
                fontSize: Spacing.lg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

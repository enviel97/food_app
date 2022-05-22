import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

class PersonalUnauth extends StatelessWidget {
  const PersonalUnauth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacing.vertical.xxl,
          KTextButton(
            'Sign in',
            width: (Dimensions.kWidth * 0.8).w,
            backgroundColor: kSecondaryColor,
            fontSize: Spacing.m,
            onPressed: () {
              RouteHelper.goTo(RouteId.getSignIn());
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            child: Divider(color: kBlackColor),
          ),
          KTextButton(
            'Sign up',
            width: (Dimensions.kWidth * 0.6).w,
            backgroundColor: kLightBackgoundColor,
            textColor: kBlackColor,
            fontSize: Spacing.m,
            onPressed: () {
              RouteHelper.goTo(RouteId.getSignUp(), arguments: 'Main');
            },
          ),
        ],
      ),
    );
  }
}

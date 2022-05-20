import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class ActionButton extends StatelessWidget {
  final Function() onSignIn;
  final Function() goToSignUp;
  final Function() goToForgotPassword;
  const ActionButton({
    required this.onSignIn,
    required this.goToSignUp,
    required this.goToForgotPassword,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacing.vertical.m,
          KTextButton(
            'Sign in',
            width: (Dimensions.kWidth * 0.8).w,
            backgroundColor: kSecondaryColor,
            fontSize: Spacing.m,
            onPressed: onSignIn,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Divider(
              color: kBlackColor,
              height: 10,
              thickness: .6,
            ),
          ),
          KTextButton(
            'Sign up',
            width: (Dimensions.kWidth * 0.6).w,
            backgroundColor: kLightBackgoundColor,
            textColor: kBlackColor,
            fontSize: Spacing.m,
            onPressed: goToSignUp,
          ),
          Spacing.vertical.sm,
          GestureDetector(
            onTap: goToForgotPassword,
            child: const Text.rich(
              TextSpan(
                text: 'Forgot password ',
                style: TextStyle(color: kPlaceholderSuperDarkColor),
                children: [
                  TextSpan(
                    text: 'CLICK HERE',
                    style: TextStyle(
                      color: kSecondaryLightColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacing.vertical.xxl,
        ],
      ),
    );
  }
}

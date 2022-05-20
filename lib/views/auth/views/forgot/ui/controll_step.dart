import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class ControllStep extends StatelessWidget {
  final int currentStep;

  final void Function() verifyEmail, forgotSubmitted;
  const ControllStep({
    required this.currentStep,
    required this.verifyEmail,
    required this.forgotSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentStep == 0) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: KTextButton(
          'Verify email',
          width: (Dimensions.kWidth * .7).w,
          backgroundColor: kSecondaryColor,
          fontSize: Spacing.m,
          onPressed: verifyEmail,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: KTextButton(
        'Change password',
        width: (Dimensions.kWidth * .7).w,
        backgroundColor: kSecondaryColor,
        fontSize: Spacing.m,
        onPressed: forgotSubmitted,
      ),
    );
  }
}

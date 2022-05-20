import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class ControllerAction extends StatelessWidget {
  final int currentStep;
  final void Function() onBack, onSubmit;
  const ControllerAction({
    required this.currentStep,
    required this.onBack,
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentStep > 0 && currentStep < 2)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: KTextButton(
                'BACK',
                backgroundColor: kSecondaryDarkColor,
                onPressed: onBack,
              ),
            ),
          ),
        if (currentStep < 2)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: KTextButton(
                currentStep == 0 ? 'NEXT' : 'CONFIRM',
                backgroundColor: kSecondaryDarkColor,
                onPressed: onSubmit,
              ),
            ),
          ),
      ],
    );
  }
}

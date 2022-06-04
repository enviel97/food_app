import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/helpers/dismiss_keyboard.dart';
import 'package:food_shop/widgets/texts/bordered_text.dart';
import 'package:get/get.dart';

class Background extends StatelessWidget {
  final String title;
  final Widget form;
  const Background({
    required this.title,
    required this.form,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageSize = (Dimensions.kWidth * 0.325).w;
    return WillPopScope(
      onWillPop: () async {
        /// prevent system button go back
        /// return:
        /// [true]: allow use system button
        /// [false]: prevent use system button
        return Future.value(false);
      },
      child: DismissKeyboard(
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: KIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                iconScale: 1.0,
                backgroundColor: kPlaceholderDarkColor,
                shape: IconButtonShape.circle,
                onPressed: () {
                  /// only goback with this
                  Navigator.of(context).pop();
                },
              ),
            ),
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            title: BorderedText(
              title,
              fontSize: Spacing.xxl,
              colorText: kTertiaryColor,
              colorStrock: kBlackColor,
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 40.0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: imageSize,
                  height: imageSize,
                ),
                Expanded(child: form)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

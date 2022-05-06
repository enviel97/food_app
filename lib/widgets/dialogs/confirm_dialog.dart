import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

class Dialog {
  const Dialog();

  static Widget confirm({
    required String title,
    required String content,
  }) {
    return AlertDialog(
      backgroundColor: kWhiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      title: const HeaderText(
        'Remove',
        textAlign: TextAlign.start,
        fontSize: Spacing.m,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          BodyText(content, textAlign: TextAlign.start),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: kBlackColor),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text(
                  'ACCEPT',
                  style: TextStyle(color: kPrimaryDarkColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';

class _Dialog {
  const _Dialog();

  static Widget confirm({
    required String title,
    required Widget content,
    bool canncelButton = true,
    bool confirmButton = true,
  }) {
    return AlertDialog(
      backgroundColor: kWhiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      title: HeaderText(
        title,
        textAlign: TextAlign.start,
        fontSize: Spacing.m,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          content,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (canncelButton)
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: kBlackColor),
                  ),
                ),
              if (confirmButton)
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

Future<void> showNoticeDialog({
  required String title,
  required Widget content,
  void Function()? onConfirm,
}) async {
  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      _Dialog.confirm(
        title: title,
        content: content,
        canncelButton: false,
      ),
    );
  }
}

Future<bool> showConfirmDialog({
  required String title,
  required Widget content,
  void Function()? onConfirm,
}) async {
  if (!(Get.isDialogOpen ?? false)) {
    final isConfirm = await Get.dialog<bool>(
      _Dialog.confirm(
        title: title,
        content: content,
      ),
    );
    if (isConfirm ?? false) {
      onConfirm?.call();
      return true;
    }
  }
  return false;
}

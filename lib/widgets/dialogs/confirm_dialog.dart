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
    void Function()? onConfirm,
    void Function()? onCancel,
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
              if (onCancel != null)
                TextButton(
                  onPressed: () {
                    onCancel.call();
                    Get.back(result: false);
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: kBlackColor),
                  ),
                ),
              if (onConfirm != null)
                TextButton(
                  onPressed: () {
                    onConfirm.call();
                    Get.back(result: true);
                  },
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
        onConfirm: () {
          onConfirm?.call();
        },
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

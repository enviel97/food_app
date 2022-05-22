import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:get/get.dart';

void showError(dynamic message) {
  String _message = 'Unknown';
  if (message is Map<String, dynamic>) {
    _message = message['message'] ?? 'Unknown';
  }
  if (message is String) {
    _message = message;
  }

  if (!Get.isSnackbarOpen) {
    Get.snackbar(
      'Error',
      _message,
      colorText: kWhiteColor,
      backgroundColor: kErrorColor.withOpacity(.8),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    );
  }
}

void showSuccess(dynamic message) {
  String _message = 'Unknown';
  if (message is Map<String, dynamic>) {
    _message = message['message'] ?? 'Unknown';
  }
  if (message is String) {
    _message = message;
  }

  if (!Get.isSnackbarOpen) {
    Get.snackbar(
      'Success',
      _message,
      colorText: kWhiteColor,
      backgroundColor: kSuccessColor.withOpacity(.8),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    );
  }
}

Future<T?> showLoading<T>(Future<T> Function() asyncFunction) async {
  if (!Get.isSnackbarOpen) {
    final result = await Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: const Center(child: CircularProgressIndicator()),
    );
    return result;
  }
  return null;
}

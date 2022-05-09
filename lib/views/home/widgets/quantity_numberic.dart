import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';

class QuantityNumberic extends StatefulWidget {
  final QuantityNumbericController? controller;
  final void Function(int number)? onChanged;
  final int maxQuantity, minQuantity, step;
  final int? initQuantity;
  const QuantityNumberic({
    Key? key,
    this.controller,
    this.onChanged,
    this.maxQuantity = 99,
    this.minQuantity = 0,
    this.step = 1,
    this.initQuantity = 1,
  }) : super(key: key);

  @override
  State<QuantityNumberic> createState() => _QuantityNumbericState();
}

class _QuantityNumbericState extends State<QuantityNumberic> {
  int quantity = 1;
  bool isSnackBarActive = false;
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!._setState(this);
    }
    _initQuantity();
  }

  @override
  void didUpdateWidget(QuantityNumberic oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initQuantity != widget.initQuantity) {
      _initQuantity();
    }
  }

  void _initQuantity() {
    quantity = widget.controller?.initQuanity ?? widget.initQuantity ?? 1;
  }

  Widget _buttonControlBuilder({
    required IconData icon,
    required Function() onPressed,
  }) {
    return KIconButton(
      icon: icon,
      backgroundColor: kWhiteColor,
      size: Spacing.lg,
      onPressed: () => setState(onPressed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: kPlaceholderSuperDarkColor.withOpacity(0.25),
            blurRadius: 5.0,
            offset: const Offset(0.0, 5.0),
          )
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buttonControlBuilder(
            icon: Icons.arrow_back_ios_rounded,
            onPressed: () => _decrease(step: widget.step),
          ),
          Spacing.horizantal.m,
          BodyText(
            '$quantity',
            fontSize: Spacing.sm,
            fontWeight: FontWeight.bold,
          ),
          Spacing.horizantal.m,
          _buttonControlBuilder(
            icon: Icons.arrow_forward_ios_rounded,
            onPressed: () => _increase(step: widget.step),
          ),
        ],
      ),
    );
  }

  void showSnackBar(String title, String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        backgroundColor: kPrimaryColor.withOpacity(0.7),
        duration: const Duration(seconds: 1),
        isDismissible: true,
      );
    }
  }

  void _increase({int step = 1}) {
    if (quantity + step > widget.maxQuantity) {
      showSnackBar('Item count', "You can't reduce less than 1");
      return;
    }
    quantity = min(widget.maxQuantity, quantity + step);
    _notification();
  }

  void _decrease({int step = 1}) {
    if (quantity - step < widget.minQuantity) {
      showSnackBar('Item count', "You can't reduce less than 1");
      return;
    }
    quantity = max(widget.minQuantity, quantity - step);
    _notification();
  }

  void _notification() {
    if (widget.controller != null) {
      widget.controller!.quantity = quantity;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(quantity);
    }
  }
}

class QuantityNumbericController {
  final int initQuanity;
  late _QuantityNumbericState? _state;
  int quantity = 1;

  QuantityNumbericController({this.initQuanity = 1});

  void _setState(_QuantityNumbericState state) {
    _state = state;
  }

  void increase({int step = 1}) {
    if (_state != null) {
      _state!._increase(step: step);
    }
  }

  void decrease({int step = 1}) {
    if (_state != null) {
      _state!._decrease(step: step);
    }
  }
}

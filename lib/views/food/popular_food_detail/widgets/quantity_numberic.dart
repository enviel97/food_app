import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';
import 'package:food_shop/widgets/texts/custom_text.dart';

class QuantityNumberic extends StatefulWidget {
  final QuantityNumbericController? controller;
  final void Function(int number)? onChanged;
  const QuantityNumberic({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<QuantityNumberic> createState() => _QuantityNumbericState();
}

class _QuantityNumbericState extends State<QuantityNumberic> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!._setState(this);
      quantity = widget.controller!.initQuanity;
    }
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
            onPressed: _decrease,
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
            onPressed: _increase,
          ),
        ],
      ),
    );
  }

  void _increase({int step = 1}) {
    quantity += step;
    _notification();
  }

  void _decrease({int step = 1}) {
    quantity = max(1, quantity - step);
    _notification();
  }

  void _notification() {
    if (widget.controller != null) {
      widget.controller!.quantiyy = quantity;
    }
  }
}

class QuantityNumbericController {
  final int initQuanity;
  late _QuantityNumbericState? _state;
  int quantiyy = 1;

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

import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:get/get.dart';

enum _StatusBorder { error, errorFocus, unactive, active, disabled }

class KTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final int? maxLength;
  final bool enabled, security, autoFocus, readOnly, isShowClearButton;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? currentNode, nextNode;
  final String? helperText;

  /// Action
  final void Function(String value)? onChanged;
  final String? Function(String? value)? onValidation;
  final void Function()? onSubmitted;
  final void Function()? onClear;

  const KTextInput({
    required this.controller,
    required this.label,
    Key? key,
    this.icon,
    this.maxLength,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,

    // flag
    this.enabled = true,
    this.security = false,
    this.readOnly = false,

    /// Action
    this.onValidation,
    this.onChanged,
    this.onSubmitted,
    this.currentNode,
    this.nextNode,
    this.helperText,
    this.autoFocus = false,
    this.onClear,
    this.isShowClearButton = true,
  }) : super(key: key);

  @override
  State<KTextInput> createState() => _KTextInputState();
}

class _KTextInputState extends State<KTextInput> {
  late TextEditingController _controller;
  String? errrNotification;
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  Color get _statusColor {
    if (errrNotification != null) {
      return kErrorColor;
    }
    if (_controller.text.isEmpty) {
      return kPlaceholderSuperDarkColor;
    }

    return kTertiaryColor;
  }

  InputBorder border(_StatusBorder status) {
    switch (status) {
      case _StatusBorder.error:
        return const OutlineInputBorder(
          borderSide: BorderSide(color: kErrorColor),
        );
      case _StatusBorder.unactive:
        {
          final conlor =
              _controller.text.isEmpty ? kPlaceholderDarkColor : kTertiaryColor;
          return OutlineInputBorder(
            borderSide: BorderSide(color: conlor),
          );
        }
      case _StatusBorder.active:
        return OutlineInputBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0.h)),
          borderSide: const BorderSide(color: kTertiaryColor),
        );
      case _StatusBorder.disabled:
        return const OutlineInputBorder(
          borderSide: BorderSide(color: kPlaceholderDarkColor),
        );
      case _StatusBorder.errorFocus:
        return OutlineInputBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0.h)),
          borderSide: const BorderSide(color: kErrorColor),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: _statusColor,
          offset: const Offset(5, 5),
        ),
      ]),
      child: TextFormField(
        autofocus: widget.autoFocus,
        focusNode: widget.currentNode,
        enabled: widget.enabled,
        controller: _controller,
        maxLines: 1,
        maxLength: widget.maxLength,
        cursorColor: kTertiaryColor,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,

        // security
        obscureText: widget.security && isHidden,
        obscuringCharacter: '◆',
        readOnly: widget.readOnly,

        decoration: InputDecoration(
          // label

          label: _buildFloatingLabel,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelStyle: const TextStyle(color: kPlaceholderSuperDarkColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color: _statusColor,
            fontWeight: FontWeight.bold,
            fontSize: Spacing.m,
          ),

          helperText: widget.helperText,
          helperStyle: const TextStyle(color: kWhiteColor),
          // error
          errorStyle: const TextStyle(
            color: kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: !widget.enabled && !widget.readOnly
              ? kPlaceholderColor
              : kWhiteColor,
          enabledBorder: border(_StatusBorder.unactive),
          focusedBorder: border(_StatusBorder.active),
          disabledBorder: border(_StatusBorder.disabled),

          // error
          errorMaxLines: 1,
          errorBorder: border(_StatusBorder.error),
          focusedErrorBorder: border(_StatusBorder.errorFocus),

          // button
          suffixIcon: _buildClearButton,
        ),
        validator: _onValidaton,
        onChanged: _onChanged,
        onFieldSubmitted: _onFieldSubbmit,
      ),
    );
  }

  Widget get _buildFloatingLabel {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: 16.0.h,
            color: _statusColor,
          ),
          Spacing.horizantal.s,
        ],
        Text(widget.label),
      ],
    );
  }

  String? _onValidaton(String? value) {
    setState(() {
      errrNotification = widget.onValidation?.call(value);
    });
    return errrNotification;
  }

  void _onChanged(String value) {
    if (value.length <= 1) setState(() {});
  }

  void _onFieldSubbmit(String value) {
    _controller.text.trim();
    if (widget.textInputAction == TextInputAction.next) {
      FocusScope.of(context).requestFocus(widget.nextNode);
    }
    if (widget.textInputAction == TextInputAction.done) {
      widget.onSubmitted?.call();
    }
  }

  Widget get _buildClearButton {
    return Wrap(
      children: [
        if (_controller.text.isNotEmpty && widget.isShowClearButton)
          IconButton(
            splashColor: Get.theme.scaffoldBackgroundColor,
            padding: const EdgeInsets.all(0.0),
            icon: const Icon(
              Icons.highlight_remove_rounded,
              color: kPlaceholderSuperDarkColor,
            ),
            onPressed: () {
              _controller.clear();
              widget.onClear?.call();
              if (mounted) setState(() {});
            },
          ),
        if (widget.security)
          IconButton(
            padding: const EdgeInsets.all(0.0),
            splashColor: Get.theme.scaffoldBackgroundColor,
            color: kPlaceholderSuperDarkColor,
            icon: Icon(
              isHidden
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
            onPressed: () {
              setState(() => isHidden = !isHidden);
            },
          ),
      ],
    );
  }
}

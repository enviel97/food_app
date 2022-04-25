import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';

enum IconButtonShape {
  round,
  circle,
}

class KIconButton extends StatelessWidget {
  final double? size;
  final IconData icon;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor, iconColor;
  final Function()? onPressed;
  final IconButtonShape shape;

  const KIconButton({
    required this.icon,
    Key? key,
    this.size,
    this.onPressed,
    this.padding = const EdgeInsets.all(8.0),
    this.backgroundColor = kPrimaryColor,
    this.iconColor = kBlackColor,
    this.shape = IconButtonShape.round,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = shape == IconButtonShape.round ? 15.0 : (size ?? 24);
    final backgroundColor =
        this.backgroundColor.withOpacity(onPressed == null ? 0.5 : 1.0);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: IconButton(
        iconSize: size ?? 24.0,
        color: iconColor,
        splashColor: kBlackColor.withOpacity(0.5),
        disabledColor: kPlaceholderDarkColor,
        padding: padding,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}

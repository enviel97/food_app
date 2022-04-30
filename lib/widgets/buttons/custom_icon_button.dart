import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double_extension.dart';
import 'package:food_shop/styles/colors.dart';

enum IconButtonShape {
  round,
  circle,
}

class KIconButton extends StatelessWidget {
  final double? size;
  final IconData icon;
  final Color backgroundColor, iconColor, shadowColor, splashColor;
  final bool removeSplash;
  final Function()? onPressed;
  final IconButtonShape shape;
  final double elevation, iconScale;

  const KIconButton({
    required this.icon,
    Key? key,
    this.size,
    this.onPressed,
    this.backgroundColor = kPrimaryColor,
    this.iconColor = kBlackColor,
    this.shape = IconButtonShape.round,
    this.removeSplash = false,
    this.shadowColor = kBlackColor,
    this.splashColor = kPrimaryDarkColor,
    this.elevation = 0.0,
    this.iconScale = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (this.size ?? 24.0).h;
    final radius = size * (shape == IconButtonShape.round ? 0.375 : 2.0).h;

    final backgroundColor = this.backgroundColor.withOpacity(
          onPressed == null ? 0.5 : this.backgroundColor.opacity,
        );

    final splashcolor = removeSplash ? kNone : splashColor.withOpacity(0.2);
    return SizedBox.fromSize(
        size: Size(size, size), // button width and height
        child: Material(
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            shadowColor: shadowColor.withOpacity(0.5),
            color: backgroundColor, // button color
            child: InkWell(
                splashColor: splashcolor, // splash color
                onTap: onPressed, //() {}, // button pressed
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(icon, color: iconColor, size: size * iconScale)
                    ]))));
  }
}

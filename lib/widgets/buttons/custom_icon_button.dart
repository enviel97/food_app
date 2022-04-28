import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';

enum IconButtonShape {
  round,
  circle,
}

class KIconButton extends StatelessWidget {
  final double? size;
  final IconData icon;
  final Color backgroundColor, iconColor;
  final bool removeSplash;
  final Function()? onPressed;
  final IconButtonShape shape;
  final double elevation;

  const KIconButton({
    required this.icon,
    Key? key,
    this.size,
    this.onPressed,
    this.backgroundColor = kPrimaryColor,
    this.iconColor = kBlackColor,
    this.shape = IconButtonShape.round,
    this.removeSplash = false,
    this.elevation = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 24.0;
    final radius = size * (shape == IconButtonShape.round ? 0.375 : 2);

    final backgroundColor = this.backgroundColor.withOpacity(
          onPressed == null ? 0.5 : this.backgroundColor.opacity,
        );

    final splashcolor = removeSplash ? kNone : kBlackColor.withOpacity(0.5);
    return SizedBox.fromSize(
        size: Size(size, size), // button width and height
        child: Material(
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)),
            shadowColor: kBlackColor.withOpacity(0.5),
            color: backgroundColor, // button color
            child: InkWell(
                splashColor: splashcolor, // splash color
                onTap: onPressed, //() {}, // button pressed
                customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(icon, color: iconColor, size: size * 0.5)
                    ]))));
  }
}

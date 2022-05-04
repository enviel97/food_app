import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:food_shop/styles/colors.dart';

class NeumorphismButton extends StatefulWidget {
  final double size;
  final Function()? onPressed;
  final Widget? child;
  final Color backgroundColor;
  const NeumorphismButton({
    Key? key,
    this.onPressed,
    this.child,
    this.size = 48.0,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  @override
  State<NeumorphismButton> createState() => _NeumorphismButtonState();
}

class _NeumorphismButtonState extends State<NeumorphismButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).backgroundColor;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final offset = isPressed ? const Offset(5, 5) : const Offset(10, 10);
    final blur = isPressed ? 2.0 : 15.0;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Listener(
        onPointerUp: (_) => setState(() => isPressed = false),
        onPointerDown: (_) => setState(() => isPressed = true),
        child: AnimatedContainer(
          height: widget.size,
          width: widget.size,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget.backgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: blur,
                  offset: -offset,
                  color: backgroundColor,
                  inset: isPressed,
                ),
                BoxShadow(
                  blurRadius: blur,
                  offset: offset,
                  color: isDarkMode
                      ? const Color(0xff23262a)
                      : const Color(0xFFa7a9af),
                  inset: isPressed,
                )
              ]),
          child: widget.child,
        ),
      ),
    );
  }
}

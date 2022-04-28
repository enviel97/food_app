import 'package:flutter/material.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';

class KSingleChildScrollView extends StatelessWidget {
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget? child;
  final bool disableScrollGrow;

  const KSingleChildScrollView({
    Key? key,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.disableScrollGrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (disableScrollGrow) {
      return ScrollConfiguration(
        behavior: RemoveGrow(),
        child: _singleScrollView,
      );
    }
    return _singleScrollView;
  }

  Widget get _singleScrollView => SingleChildScrollView(
        scrollDirection: scrollDirection,
        reverse: reverse,
        padding: padding,
        primary: primary,
        physics: physics,
        controller: controller,
        child: child,
      );
}

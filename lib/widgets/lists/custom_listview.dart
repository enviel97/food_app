import 'package:flutter/material.dart';
import 'package:food_shop/widgets/page/empty.page.dart';
import 'scroll_behavior/disable_grow.dart';

class KListView<T> extends StatelessWidget {
  final List<T> datas;
  final Widget Function(T data, int index) itemBuilder;
  final Widget Function()? emptyBuilder;
  final bool shrinkWrap, disableScrollGrow;
  final EdgeInsetsGeometry padding;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;

  const KListView({
    required this.datas,
    required this.itemBuilder,
    Key? key,
    this.emptyBuilder,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(24.0),
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.disableScrollGrow = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (datas.isEmpty) {
      return _emptyView;
    }
    if (disableScrollGrow) {
      return ScrollConfiguration(
        behavior: RemoveGrow(),
        child: _listview,
      );
    }
    return _listview;
  }

  Widget get _listview {
    return ListView.builder(
      controller: controller,
      primary: primary,
      physics: physics,
      scrollDirection: scrollDirection,
      itemBuilder: _itemBuilder,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: datas.length,
    );
  }

  Widget get _emptyView {
    if (emptyBuilder != null) {
      return emptyBuilder!();
    }
    return const Empty();
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return itemBuilder(datas[index], index);
  }
}

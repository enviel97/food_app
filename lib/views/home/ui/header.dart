import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/neumorphism_button.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final double size;
  final int pageIndex;
  final void Function()? onChangedPage, onSearch;
  final AnimationController iconController;

  const Header({
    required this.iconController,
    Key? key,
    this.size = 100.0,
    this.onChangedPage,
    this.onSearch,
    this.pageIndex = 0,
  }) : super(key: key);

  Widget _scrollControllerButton() {
    return NeumorphismButton(
      backgroundColor: kPlaceholderDarkColor,
      onPressed: onChangedPage?.call,
      child: AnimatedIcon(
        icon: AnimatedIcons.list_view,
        progress: iconController,
        semanticLabel: 'Show menu',
      ),
    );
  }

  Widget _searchButton() {
    return NeumorphismButton(
      onPressed: () {},
      child: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.search, color: kBlackColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      _scrollControllerButton(),
      Spacing.horizantal.xs,
      _searchButton(),
    ];

    return SafeArea(
      minimum: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderText('Viet Nam', fontWeight: FontWeight.bold),
                const BodyText('Ho Chi Minh city',
                    color: kPlaceholderSuperDarkColor)
              ],
            ),
          ),
          ...actions,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size.h);
}

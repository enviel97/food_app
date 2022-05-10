import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';

class KBottomNavigationProps {
  final String label;
  final IconData icon;
  final Widget view;

  KBottomNavigationProps(this.label, this.icon, this.view);

  BubbleBottomBarItem get toView {
    final radius = 30.0.h / 2;
    return BubbleBottomBarItem(
      backgroundColor: kPrimaryColor,
      icon: Icon(icon, color: kSecondaryLightColor),
      activeIcon: CircleAvatar(
        backgroundColor: kSecondaryColor,
        radius: radius,
        child: Icon(
          icon,
          color: kWhiteColor,
          size: radius,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: kSecondaryColor,
        ),
      ),
    );
  }
}

class KBottomAppBar extends StatelessWidget {
  final void Function(int? index) onChangePage;

  final Iterable<BubbleBottomBarItem> items;

  final int currentIndex;

  const KBottomAppBar({
    required this.onChangePage,
    required this.items,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .5,
      iconSize: 24.0.h,
      currentIndex: currentIndex,
      onTap: onChangePage,
      elevation: 8,
      tilesPadding: EdgeInsets.symmetric(
        vertical: 10.0.h,
        horizontal: 15.0.h,
      ),
      fabLocation: BubbleBottomBarFabLocation.end, //new
      hasNotch: true, //new
      hasInk: true, //new, gives a cute ink effect
      inkColor: Colors.black12, //optional, uses theme color if not specified
      items: [...items],
    );
  }
}

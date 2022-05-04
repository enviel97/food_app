import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/neumorphism_button.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class Header extends StatefulWidget with PreferredSizeWidget {
  final double size;
  final void Function()? onChangedPage, onSearch;

  const Header({
    Key? key,
    this.size = 100.0,
    this.onChangedPage,
    this.onSearch,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();

  @override
  Size get preferredSize => Size.fromHeight(size);
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  late AnimationController _iconController;
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    _iconController = AnimationController(duration: _duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const BodyText(
                  'Ho Chi Minh city',
                  color: kPlaceholderSuperDarkColor,
                ),
              ],
            ),
          ),
          const NeumorphismButton(
            size: 48.0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.search,
                color: kBlackColor,
              ),
            ),
          ),
          Spacing.horizantal.xs,
          NeumorphismButton(
            backgroundColor: kPlaceholderDarkColor,
            onPressed: _onChangedPage,
            child: AnimatedIcon(
              icon: AnimatedIcons.list_view,
              progress: _iconController,
              semanticLabel: 'Show menu',
            ),
          ),
        ],
      ),
    );
  }

  void _onChangedPage() {
    if (_iconController.isCompleted) {
      _iconController.reverse();
    }
    if (_iconController.isDismissed) {
      _iconController.forward();
    }
    if (widget.onChangedPage != null) {
      widget.onChangedPage!();
    }
  }
}

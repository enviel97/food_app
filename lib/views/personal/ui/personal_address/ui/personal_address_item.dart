import 'package:flutter/material.dart';
import 'package:food_shop/models/address.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_icon_button.dart';

class PersonAddressItem extends StatelessWidget {
  final Address address;
  final void Function() onPressed;

  const PersonAddressItem({
    required this.address,
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  IconData get _icon {
    switch (address.type) {
      case AddressType.home:
        return Icons.home_filled;
      case AddressType.company:
        return Icons.work;
      case AddressType.other:
        return Icons.gps_fixed_rounded;
    }
  }

  Color get _backgroundColor {
    switch (address.type) {
      case AddressType.home:
        return kTertiaryColor;
      case AddressType.company:
        return kPrimaryDarkColor;
      case AddressType.other:
        return kSecondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: KIconButton(
        size: Spacing.xxl,
        iconScale: .5,
        backgroundColor: _backgroundColor,
        iconColor: kWhiteColor,
        icon: _icon,
        onPressed: onPressed,
      ),
    );
  }
}

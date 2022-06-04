import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/personal/dependencies/address/address.controllers.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/texts/header_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ui/map.dart';

class Address extends StatefulWidget {
  final double? longitude, latitude;

  const Address({
    Key? key,
    this.longitude,
    this.latitude,
  }) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
            Map(),
            Expanded(
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      backgroundColor: kWhiteColor,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: KBackButton(backgroundColor: kPrimaryColor),
      ),
      centerTitle: false,
      title: const HeaderText(
        'Address',
        fontSize: Spacing.lg,
        fontWeight: FontWeight.w500,
        color: kBlackColor,
      ),
    );
  }
}

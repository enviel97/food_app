import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/address.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/routes/routes.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:food_shop/widgets/lists/custom_listview.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

import 'ui/personal_address_item.dart';

class PersonalAddress extends StatefulWidget {
  final String userId;
  const PersonalAddress({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalAddress> createState() => _PersonalAddressState();
}

class _PersonalAddressState extends State<PersonalAddress> {
  final List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
    // addresses.clear();
    // addresses.addAll(List.generate(0, (_) => Address.faker()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Spacing.xxxl,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 15.0,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0.h),
        ),
        boxShadow: [
          BoxShadow(
            color: kSecondaryLightColor.withOpacity(.3),
            blurRadius: 10,
            offset: const Offset(-5, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          const BodyText(
            'Address',
            fontSize: Spacing.m,
            color: kPlaceholderSuperDarkColor,
            fontWeight: FontWeight.w300,
            textAlign: TextAlign.left,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: KListView<Address>(
                reverse: true,
                padding: const EdgeInsets.all(0.0),
                datas: addresses,
                scrollDirection: Axis.horizontal,
                itemBuilder: (data, _) => PersonAddressItem(
                  address: data,
                  onPressed: () {
                    RouteHelper.goTo(RouteId.getAddress(
                      latitude: data.coordinates.latitude,
                      longitude: data.coordinates.longitude,
                    ));
                  },
                ),
                emptyBuilder: _emptyBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyBuilder() {
    return KTextButton(
      'Add new address',
      backgroundColor: kSecondaryColor,
      onPressed: () {
        RouteHelper.goTo(RouteId.getAddress());
      },
    );
  }
}

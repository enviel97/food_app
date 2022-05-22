import 'package:flutter/material.dart';
import 'package:food_shop/extentions/data_time.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/personal/widgets/info.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class PesonalInfo extends StatelessWidget {
  final String name, email;
  final DateTime birth, updateAt;
  const PesonalInfo({
    required this.name,
    required this.email,
    required this.birth,
    required this.updateAt,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing.vertical.xxl,
        Info(label: 'Email', value: email),
        Info(label: 'Name', value: name),
        Info(label: 'Birth', value: birth.toDate),
        Spacing.vertical.xl,
        Column(
          children: [
            const BodyText(
              'last update',
              color: kPlaceholderDarkColor,
            ),
            BodyText(
              updateAt.toDate,
              color: kPlaceholderDarkColor,
            )
          ],
        )
      ],
    );
  }
}
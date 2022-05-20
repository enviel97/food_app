import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/extentions/string.extension.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/personal/widgets/info.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';

class ConfirmStep extends StatelessWidget {
  final String? email, birth, name;
  final File? avatar;
  final Gender? gender;

  const ConfirmStep({
    Key? key,
    this.email,
    this.gender,
    this.birth,
    this.avatar,
    this.name,
  }) : super(key: key);

  Widget get _buildAvatar {
    final size = 80.0.h;
    Image image = Image.asset(
      './assets/images/${gender?.name ?? 'private'}.png',
      fit: BoxFit.cover,
    );
    if (avatar != null) {
      image = Image.file(
        avatar!,
        fit: BoxFit.cover,
      );
    }
    return CircleAvatar(
      radius: size / 2 + 5,
      backgroundColor: kTertiaryColor,
      child: CircleAvatar(
        radius: size / 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size),
          child: image,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(child: _buildAvatar),
          Expanded(
              flex: 2,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Info(label: 'Birth', value: birth ?? '@email'),
                Info(
                    label: 'Gender',
                    value: (gender?.name ?? '@gender').firstUperCase)
              ]))
        ]),
        Info(label: 'Email', value: email ?? '@email'),
        Info(label: 'Name', value: name ?? '@name'),
        Spacing.vertical.sm,
        KTextButton(
          'Sign Up',
          width: Dimensions.kWidth * .5,
          onPressed: () {},
        ),
      ],
    );
  }
}

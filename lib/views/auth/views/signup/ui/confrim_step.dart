import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/extentions/data_time.extension.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/extentions/string.extension.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/routes/routes.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:food_shop/views/personal/widgets/info.dart';
import 'package:food_shop/widgets/buttons/custom_text_button.dart';
import 'package:get/get.dart';

class ConfirmStep extends StatelessWidget {
  final String? email, birth, name, password;
  final File? avatar;
  final Gender? gender;

  const ConfirmStep({
    Key? key,
    this.email,
    this.gender,
    this.birth,
    this.avatar,
    this.name,
    this.password,
  }) : super(key: key);

  Widget get _buildAvatar {
    final size = 80.0.h;
    Image image = Image.asset(
      './assets/images/${gender?.name ?? 'private'}.png',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
    if (avatar != null) {
      image = Image.file(
        avatar!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    return CircleAvatar(
      radius: size / 2 + 5,
      backgroundColor: kTertiaryColor,
      child: CircleAvatar(
        backgroundColor: kLightBackgoundColor,
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
          onPressed: () async {
            final isSuccess = await showLoading<bool>(
              () => Get.find<AuthController>().signUp(
                email: email!,
                password: password!,
                birth: DateTimeX.fromString(birth!, format: 'dd-MM-yyyy'),
                gender: (gender?.name ?? '@gender').firstUperCase,
                name: name!,
                avatar: avatar,
              ),
            );

            if (!(isSuccess ?? false)) return;
            final agrument = Get.arguments;
            if (agrument != null) {
              RouteHelper.replace(RouteId.getSignIn(),
                  arguments: {'email': email, 'password': password});
              return;
            }
            Navigator.of(context).maybePop({
              'email': email,
              'password': password,
            });
            return;
          },
        ),
      ],
    );
  }
}

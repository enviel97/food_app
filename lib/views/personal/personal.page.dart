import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:food_shop/views/personal/styles/dimentions.dart';
import 'package:food_shop/widgets/images/avatar.dart';
import 'package:get/get.dart';

import 'ui/personal_unauth.dart';
import 'ui/personnal_info.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: PersonalDimensions.kHeightInfoDimention,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(bottom: 40.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetBuilder<AuthController>(builder: (controller) {
                return Avatar(
                  url: getImageUrl(controller.user?.avatar ?? ''),
                  gender: controller.user?.gender ?? Gender.private,
                );
              }),
              GetBuilder<AuthController>(builder: (controller) {
                if (controller.user != null) {
                  final user = controller.user!;
                  return Expanded(
                    child: PesonalInfo(
                      email: user.email,
                      name: user.name,
                      updateAt: DateTime.now(),
                      birth: user.birth,
                    ),
                  );
                }
                return const PersonalUnauth();
              })
            ],
          ),
        ),
      ),
    );
  }
}

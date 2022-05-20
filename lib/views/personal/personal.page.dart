import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/views/personal/styles/dimentions.dart';
import 'package:food_shop/widgets/images/avatar.dart';

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
              Avatar(url: ''),
              // PesonalInfo(
              //   email: '',
              //   name: '',
              //   updateAt: DateTime.now(),
              //   birth: DateTime.now(),
              // ),
              PersonalUnauth(),
            ],
          ),
        ),
      ),
    );
  }
}

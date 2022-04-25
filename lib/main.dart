import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/styles/colors.dart';

import 'views/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: kNone,
  ));
  runApp(const App());
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/styles/colors.dart';

import 'dependencies.dart' as dep;
import 'views/app.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: kNone,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  runApp(const App());
}

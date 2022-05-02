import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/styles/colors.dart';

import 'repository/dependencies.dart';
import 'src/app.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: kNone,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Dependencies.init();
  runApp(const App());
}

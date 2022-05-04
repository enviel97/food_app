import 'package:flutter/material.dart';
import 'package:food_shop/src/home/view/home_view/home.page.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:get/get.dart';

import 'home/view/popular_food_view/popular_food_detail.dart';
import 'home/view/recomend_food_view/recommened_food_detail.page.dart';

part 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      title: 'Food App',
      getPages: RouteHelper._routes,
    );
  }
}

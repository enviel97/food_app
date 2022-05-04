import 'package:flutter/material.dart';
import 'package:food_shop/views/home/view/home/home.page.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:get/get.dart';

import 'home/view/home/views/recomend_food_view/recommened_food_detail.page.dart';
import 'home/view/home/views/popular_food_view/popular_food_detail.dart';

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

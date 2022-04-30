import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:get/get.dart';

import 'food/recommened_food_detail/recommened_food_detail.page.dart';

// import 'home/home.page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      title: 'Food App',
      home: RecommenedFoodDetail(
        food: Food.faker(),
      ),
    );
  }
}

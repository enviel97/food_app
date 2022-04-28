import 'package:flutter/material.dart';
import 'package:food_shop/models/food.dart';
import 'package:food_shop/theme/app_theme.dart';
import 'package:food_shop/views/food/popular_food_detail/popular_food_detail.dart';
import 'package:get/get.dart';

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
      home: PopularFoodDetail(
        food: Food.faker(),
      ),
    );
  }
}

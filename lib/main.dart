import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:get/get.dart';

import 'dependencies/dependencies.dart' as dep;
import 'routes/routes.dart';
import 'theme/app_theme.dart';
import 'views/auth/dependencies/auth.controller.dart';
import 'views/home/dependencies/common_produtcts/popular_product.controller.dart';
import 'views/home/dependencies/popular_product/recommended_food.controller.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: kNone,
  ));

  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Disable change on rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetBuilder<PopularFoodConroller>(builder: (_) {
      return GetBuilder<RecommendedFoodConroller>(builder: (_) {
        return GetBuilder<AuthController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            /** Just suport one theme */
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.lightTheme(context),
            title: 'Food App',
            initialRoute: RouteId.getSplash(),
            getPages: Routes.config,
          );
        });
      });
    });
  }
}

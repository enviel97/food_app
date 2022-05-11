import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home/controllers/popular_product.controller.dart';
import 'home/controllers/recommended_food.controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final _durationAnimation = const Duration(seconds: 2);
  final _durationNavigation = const Duration(seconds: 3);
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _loadResource();

    _controller = AnimationController(vsync: this, duration: _durationAnimation)
      ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    Timer(_durationNavigation, () {
      RouteHelper.replace(RouteId.getMain());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: Dimensions.kWidth / 2,
                width: Dimensions.kWidth / 2,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Spacing.vertical.xxxl,
          Text(
            'Food App',
            style: GoogleFonts.lobster(
              fontSize: Spacing.xl * 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Fresher - Bester - Happier',
            style: GoogleFonts.lobster(
              fontSize: Spacing.lg,
              color: kPlaceholderDarkColor,
            ),
          )
        ],
      ),
    );
  }

  Future<void> _loadResource() async {
    if (mounted) {
      Future.wait([
        Get.find<PopularFoodConroller>().getPopularFoodList(),
        Get.find<RecommendedFoodConroller>().getRecommendedFoodList(),
      ]);
    }
  }
}

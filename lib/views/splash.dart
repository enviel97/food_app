import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/auth/controllers/auth.controller.dart';
import 'package:food_shop/widgets/dialogs/confirm_dialog.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'home/controllers/popular_product.controller.dart';
import 'home/controllers/recommended_food.controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final _durationAnimation = const Duration(seconds: 3);
  final _durationCrossFade = const Duration(microseconds: 500);
  final _durationOpacity = const Duration(milliseconds: 3500);
  late Animation<double> _animation;

  late AnimationController _controller;
  bool isLoaded = false, needShowLoading = false;

  @override
  void initState() {
    super.initState();
    _loadResource();

    _controller = AnimationController(vsync: this, duration: _durationAnimation)
      ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _showLoading();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildWelcomeUser() {
    return Column(children: [
      const Text('Food App',
          style: TextStyle(
              fontFamily: 'Decorate',
              fontSize: Spacing.xl * 1.2,
              fontWeight: FontWeight.bold)),
      const Text('Fresher - Bester - Happier',
          style: TextStyle(
              fontFamily: 'Decorate',
              fontSize: Spacing.lg,
              color: kPlaceholderDarkColor))
    ]);
  }

  Widget _bulildWelcomeNew(String name) {
    return Column(children: [
      const Text('Welcome back',
          style: TextStyle(
              fontFamily: 'Decorate',
              fontSize: Spacing.xl * 1.2,
              fontWeight: FontWeight.bold,
              color: kPlaceholderSuperDarkColor)),
      Text(name,
          style: const TextStyle(
              fontFamily: 'Decorate', fontSize: Spacing.lg, color: kBlackColor))
    ]);
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
          GetBuilder<AuthController>(
            builder: (controller) {
              return AnimatedCrossFade(
                crossFadeState: controller.user == null
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                secondChild: _bulildWelcomeNew(controller.user?.name ?? ''),
                firstChild: _buildWelcomeUser(),
                duration: _durationCrossFade,
              );
            },
          ),
          AnimatedOpacity(
            duration: const Duration(microseconds: 200),
            opacity: _animation.isCompleted ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BodyText('Loading'),
                  Spacing.horizantal.m,
                  const SizedBox.square(
                    dimension: 16.0,
                    child: CircularProgressIndicator(color: kTertiaryColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> checkPermission() async {
    final checked = await InternetConnectionChecker().hasConnection;
    return checked;
  }

  Future<void> _loadResource() async {
    if (mounted) {
      final isPermission = await checkPermission();
      if (!isPermission) {
        showNoticeDialog(
            title: 'Error',
            content: const BodyText(
              '''This app is required open internet to get data. App will be exit right now''',
            ),
            onConfirm: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            });
        return;
      }
      await Future.wait([
        Get.find<PopularFoodConroller>().getPopularFoodList(),
        Get.find<RecommendedFoodConroller>().getRecommendedFoodList(),
      ]).then(
        (_) {
          Get.find<AuthController>().getUser().then((value) {
            setState(() => isLoaded = true);
            Timer(_durationOpacity, () {
              RouteHelper.replace(RouteId.getMain());
            });
          });
        },
      );
    }
  }

  void _showLoading() {
    Timer(_durationOpacity, () {
      if (mounted) {
        setState(() {});
      }
    });
  }
}

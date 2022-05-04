import 'package:flutter/material.dart';
import 'package:food_shop/widgets/lists/scroll_behavior/disable_grow.dart';

import 'ui/food_banner.dart';
import 'ui/food_popular.dart';
import 'ui/header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;
  late int _currentPage;
  final Duration _duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    _currentPage = 0;
    _controller = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(onChangedPage: _onPressed),
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            scrollBehavior: RemoveGrow(),
            controller: _controller,
            children: [
              Container(
                // height: HomeDimensions.kFoodBanner,
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: const FoodBanner(),
              ),
              const FoodPopular(),
            ],
          ),
        ],
      ),
    );
  }

  void _onPressed() {
    if (_currentPage == 0) {
      _controller.nextPage(
        duration: _duration,
        curve: Curves.easeInOut,
      );
      _currentPage = 1;
    } else {
      _controller.previousPage(
        duration: _duration,
        curve: Curves.easeInOut,
      );
      _currentPage = 0;
    }
  }
}

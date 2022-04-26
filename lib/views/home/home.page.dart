import 'package:flutter/material.dart';

import 'ui/food_banner.dart';
import 'ui/header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // modified
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: height * 2 / 5, child: const FoodBanner()),
          ],
        ),
      ),
    );
  }
}

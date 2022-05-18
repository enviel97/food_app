import 'package:flutter/material.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class ErrorLoad extends StatelessWidget {
  const ErrorLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(child: HeaderText('Error on get food')),
    );
  }
}

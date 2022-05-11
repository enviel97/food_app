import 'package:flutter/material.dart';
import 'package:food_shop/widgets/buttons/custom_back_button.dart';
import 'package:food_shop/widgets/texts/header_text.dart';

class ErrorLoad extends StatelessWidget {
  const ErrorLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: KBackButton(),
          ),
          const Expanded(child: Center(child: HeaderText('Error on get food'))),
        ],
      ),
    );
  }
}

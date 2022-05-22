// The DismissKeybaord widget (it's reusable)
import 'package:flutter/material.dart';

void dimissKeyBoard(BuildContext context) {
  final currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => dimissKeyBoard(context),
      child: child,
    );
  }
}

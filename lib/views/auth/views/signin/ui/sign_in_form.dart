import 'package:flutter/material.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/auth/helpers/validation.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

class SignInForm extends StatelessWidget {
  final TextEditingController username, password;
  final void Function() onDone;

  const SignInForm({
    required this.username,
    required this.password,
    required this.onDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passFocus = FocusNode();
    return Column(
      children: [
        KTextInput(
          controller: username,
          label: 'Email',
          icon: Icons.email_rounded,
          onValidation: const Validation('Email').require,
          textInputAction: TextInputAction.next,
          nextNode: passFocus,
        ),
        Spacing.vertical.lg,
        KTextInput(
          currentNode: passFocus,
          controller: password,
          label: 'Password',
          security: true,
          onValidation: const Validation('Password').require,
          icon: Icons.lock_open_rounded,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

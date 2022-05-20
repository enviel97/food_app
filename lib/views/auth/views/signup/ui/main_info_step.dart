import 'package:flutter/material.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/auth/helpers/validation.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

class MainInfoStep extends StatelessWidget {
  final TextEditingController email, password, confirmPassword;
  final GlobalKey<FormState> state;

  const MainInfoStep(
    this.state, {
    required this.email,
    required this.password,
    required this.confirmPassword,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fPassword = FocusNode();
    final fPasswordConfirm = FocusNode();
    return Form(
      key: state,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          KTextInput(
            controller: email,
            autoFocus: false,
            label: 'Email',
            onValidation: const Validation('Email').isEmail,
            textInputAction: TextInputAction.next,
            nextNode: fPassword,
          ),
          Spacing.vertical.lg,
          KTextInput(
            controller: password,
            label: 'Password',
            onValidation: const Validation('Password').isPassword,
            textInputAction: TextInputAction.next,
            security: true,
            currentNode: fPassword,
            nextNode: fPasswordConfirm,
          ),
          Spacing.vertical.lg,
          KTextInput(
            controller: confirmPassword,
            label: 'Password Confirm',
            onValidation: (value) =>
                const Validation('Password Confirm').isPasswordConfirm(
              value,
              password.text,
            ),
            currentNode: fPasswordConfirm,
            security: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

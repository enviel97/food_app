import 'package:flutter/material.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/auth/helpers/validation.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

class VerifyPasswordForm extends StatelessWidget {
  final TextEditingController password, passwordConfirm;
  final void Function() onSubmitted;
  final GlobalKey<FormState> state;

  const VerifyPasswordForm({
    required this.state,
    required this.password,
    required this.passwordConfirm,
    required this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fPasswordConfirm = FocusNode();
    return Form(
      key: state,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          KTextInput(
            controller: password,
            label: 'Password',
            onValidation: const Validation('Password').isPassword,
            textInputAction: TextInputAction.next,
            security: true,
            nextNode: fPasswordConfirm,
            helperText: '* Please input your password',
          ),
          Spacing.vertical.lg,
          KTextInput(
            controller: passwordConfirm,
            label: 'Password Confirm',
            onValidation: (value) =>
                const Validation('Password Confirm').isPasswordConfirm(
              value,
              password.text,
            ),
            currentNode: fPasswordConfirm,
            security: true,
            textInputAction: TextInputAction.done,
            onSubmitted: onSubmitted,
            helperText: '* Please input your password confirm',
          ),
        ],
      ),
    );
  }
}

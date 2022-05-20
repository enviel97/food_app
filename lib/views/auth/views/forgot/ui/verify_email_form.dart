import 'package:flutter/material.dart';
import 'package:food_shop/views/auth/helpers/validation.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

class VerifyEmailForm extends StatelessWidget {
  final TextEditingController email;
  final void Function() onSubmitted;
  final GlobalKey<FormState> state;

  const VerifyEmailForm({
    required this.state,
    required this.email,
    required this.onSubmitted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KTextInput(
            controller: email,
            autoFocus: false,
            label: 'Email',
            onValidation: const Validation('Email').isEmail,
            textInputAction: TextInputAction.done,
            helperText: '* Please input your email',
            onSubmitted: onSubmitted,
          ),
        ],
      ),
    );
  }
}

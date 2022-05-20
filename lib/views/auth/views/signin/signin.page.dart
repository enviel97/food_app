import 'package:flutter/material.dart';
import 'package:food_shop/views/app.dart';
import 'package:food_shop/views/auth/ui/background.dart';
import 'package:food_shop/views/auth/views/signin/ui/action_buttons.dart';
import 'package:food_shop/widgets/lists/custom_single_child_scrollview.dart';

import 'ui/sign_in_form.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  final _formState = GlobalKey<FormState>();

  @override
  void initState() {
    usernameController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');

    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      title: 'Sign In',
      form: Form(
        key: _formState,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: KSingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Column(
            children: [
              SignInForm(
                password: passwordController,
                username: usernameController,
                onDone: _onSignin,
              ),
              ActionButton(
                onSignIn: _onSignin,
                goToSignUp: _goToSignUp,
                goToForgotPassword: _goToForgotPassword,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignin() {
    if (_formState.currentState?.validate() ?? false) {
      print('Valid');
      return;
    }
    print('Invalid');
  }

  Future<void> _goToForgotPassword() async {
    final user = await RouteHelper.goTo(
      RouteId.getForgotPassword(usernameController.text),
    );
    if (user != null) {
      usernameController.text = user['email'] ?? '';
      passwordController.text = user['password'] ?? '';
    }
  }

  Future<void> _goToSignUp() async {
    final user = await RouteHelper.goTo(RouteId.getSignUp());
  }
}

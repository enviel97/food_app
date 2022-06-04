import 'package:flutter/material.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/routes/helpers/route.helpers.dart';
import 'package:food_shop/routes/routes.dart';
import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:food_shop/views/auth/ui/background.dart';
import 'package:food_shop/views/auth/views/signin/ui/action_buttons.dart';
import 'package:food_shop/widgets/lists/custom_single_child_scrollview.dart';
import 'package:get/get.dart';

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
    usernameController = TextEditingController(text: 'admin1@gmail.vom');
    passwordController = TextEditingController(text: '123QWEasd?!');
    super.initState();
    _initController();
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
        autovalidateMode: AutovalidateMode.disabled,
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

  Future<void> _onSignin() async {
    if (_formState.currentState?.validate() ?? false) {
      final controller = Get.find<AuthController>();
      await showLoading(() async => await controller.signIn(
            usernameController.text,
            passwordController.text,
          ));
      if (!controller.isError && controller.isLoaded) {
        RouteHelper.goTo(RouteId.getSplash());
        return;
      }
    }
  }

  Future<void> _goToForgotPassword() async {
    final user = await RouteHelper.goTo(
      RouteId.getForgotPassword(usernameController.text),
    );
    _configController(user);
  }

  Future<void> _goToSignUp() async {
    final user = await RouteHelper.goTo(RouteId.getSignUp());
    _configController(user);
  }

  void _configController(dynamic user) {
    if (user == null) return;
    if (user is Map) {
      usernameController.text = user['email'] ?? '';
      passwordController.text = user['password'] ?? '';
    }
  }

  void _initController() {
    _configController(Get.arguments);
  }
}

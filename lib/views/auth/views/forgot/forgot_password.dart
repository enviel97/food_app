import 'package:flutter/material.dart';
import 'package:food_shop/helpers/widget_functions.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/views/auth/dependencies/auth.controller.dart';
import 'package:food_shop/views/auth/ui/background.dart';
import 'package:food_shop/views/auth/views/forgot/ui/controll_step.dart';
import 'package:get/get.dart';

import 'ui/verify_email_form.dart';
import 'ui/verify_password_form.dart';

class ForgotPassword extends StatefulWidget {
  final String initEmail;
  const ForgotPassword(
    this.initEmail, {
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailState = GlobalKey<FormState>();
  final passwordState = GlobalKey<FormState>();

  int _currentStep = 0;
  late TextEditingController email, password, passwordConfirm;

  @override
  void initState() {
    super.initState();

    email = TextEditingController(text: widget.initEmail);
    password = TextEditingController();
    passwordConfirm = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Get.theme;
    return Background(
      title: 'Reset',
      form: Theme(
        data: themeData.copyWith(
          colorScheme: themeData.colorScheme.copyWith(
            primary: kTertiaryColor,
            onSurface: kBlackColor,
          ),
        ),
        child: Stepper(
          controlsBuilder: (_, __) => ControllStep(
            currentStep: _currentStep,
            verifyEmail: _verifyEmail,
            forgotSubmitted: _forgotSubmitted,
          ),
          onStepTapped: (tapIndex) {
            if (mounted && _currentStep == 1) {
              password.clear();
              passwordConfirm.clear();
              setState(() => _currentStep = 0);
            }
          },
          currentStep: _currentStep,
          type: StepperType.horizontal,
          steps: [
            Step(
              isActive: _currentStep >= 0,
              state: _currentStep == 0 ? StepState.editing : StepState.complete,
              title: const Text('Input your email'),
              content: VerifyEmailForm(
                state: emailState,
                email: email,
                onSubmitted: _verifyEmail,
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              state: _currentStep == 1 ? StepState.editing : StepState.indexed,
              title: const Text('Confirm your password'),
              content: VerifyPasswordForm(
                state: passwordState,
                password: password,
                passwordConfirm: passwordConfirm,
                onSubmitted: _forgotSubmitted,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _checkValidation(
    FormState? state, {
    required Future<Verify> Function() fetch,
    required void Function() onSuccess,
  }) async {
    if (!(state?.validate() ?? false)) return;

    final verify = await showLoading(fetch);
    if (verify?.status ?? false) {
      onSuccess();
    } else {
      showError(verify?.message ?? 'Unknown');
    }
  }

  Future<void> _verifyEmail() async {
    await _checkValidation(
      emailState.currentState,
      fetch: () async =>
          await Get.find<AuthController>().verifyUsername(email.text),
      onSuccess: () => setState(() => _currentStep += 1),
    );
  }

  void _forgotSubmitted() async {
    await _checkValidation(
      passwordState.currentState,
      fetch: () async => await Get.find<AuthController>()
          .changePassword(email.text, password.text),
      onSuccess: () => Get.back(result: {
        'email': email.text,
        'password': password.text,
      }),
    );
  }
}

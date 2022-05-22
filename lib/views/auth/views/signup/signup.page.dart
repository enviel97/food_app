import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/views/auth/ui/background.dart';
import 'package:food_shop/views/auth/views/signup/ui/controller_action.dart';
import 'package:food_shop/widgets/helpers/dismiss_keyboard.dart';
import 'package:get/get.dart';

import 'ui/confrim_step.dart';
import 'ui/extend_info_step.dart';
import 'ui/main_info_step.dart';

enum _ValidStep { main, extend }

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int _currentStep = 0;

  late TextEditingController email, password, passwordConfirm, birth, name;
  Gender gender = Gender.private;
  File? avatar;
  final _key = [GlobalKey(), GlobalKey(), GlobalKey()];

  final mainStep = GlobalKey<FormState>();
  final extendStep = GlobalKey<FormState>();
  final Map<_ValidStep, bool?> valids = {
    for (_ValidStep step in _ValidStep.values) step: null
  };

  @override
  void initState() {
    email = TextEditingController(text: 'admin1@gmail.com');
    password = TextEditingController(text: '123QWEasd?!');
    passwordConfirm = TextEditingController(text: '123QWEasd?!');
    birth = TextEditingController();
    name = TextEditingController(text: 'Admin');
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    birth.dispose();
    super.dispose();
  }

  StepState _buildState(int tapState) {
    if (_currentStep == tapState) {
      return StepState.editing;
    }
    final valid = valids[_ValidStep.values[tapState]];
    if (valid == null) {
      return StepState.indexed;
    }
    if (valid) {
      return StepState.complete;
    }
    return StepState.error;
  }

  void _showNotice(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Notice',
        message,
        backgroundColor: kSecondaryColor,
        colorText: kWhiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Get.theme;
    return Background(
      title: 'Sign Up',
      form: Theme(
        data: themeData.copyWith(
          colorScheme: themeData.colorScheme.copyWith(
            primary: kTertiaryColor,
            onSurface: kBlackColor,
          ),
        ),
        child: Stepper(
          controlsBuilder: (_, __) => ControllerAction(
              currentStep: _currentStep, onBack: _onBack, onSubmit: _onSubmit),
          physics: const ClampingScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: _onStepTapped,
          type: StepperType.vertical,
          steps: [
            Step(
              isActive: _currentStep >= 0,
              state: _buildState(0),
              title: const Text('Input your email'),
              content: MainInfoStep(
                mainStep,
                key: _key[0],
                email: email,
                password: password,
                confirmPassword: passwordConfirm,
              ),
            ),
            Step(
              isActive: _currentStep >= 1,
              state: _buildState(1),
              title: const Text('Please give me some infomation of you'),
              content: ExtendInfoStep(
                extendStep,
                key: _key[1],
                onAvatarChange: (File? images) => avatar = images,
                onGenderChange: (Gender? gender) {
                  setState(() {
                    this.gender = gender ?? Gender.private;
                  });
                },
                birth: birth,
                name: name,
                currentGender: gender,
              ),
            ),
            Step(
              isActive: _currentStep >= 2,
              state: StepState.indexed,
              title: const Text('Confirm your account'),
              content: ConfirmStep(
                key: _key[2],
                birth: birth.text,
                email: email.text,
                name: name.text,
                gender: gender,
                avatar: avatar,
                password: password.text,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _goTo(int index) {
    Scrollable.ensureVisible(
      _key[index].currentContext!,
      curve: Curves.fastOutSlowIn,
      duration: kThemeAnimationDuration,
    );

    setState(() => _currentStep = index);
  }

  void _onStepTapped(int index) {
    dimissKeyBoard(context);
    if (index == 2) {
      final _mainStep = isMainValid;
      final _extendStep = isExtendValid;
      if (_mainStep && _extendStep) {
        _goTo(2);
      } else {
        _showNotice('You should fill all field of sign up form');
        setState(() {});
      }
    } else {
      _goTo(index);
    }
  }

  void _onBack() {
    dimissKeyBoard(context);
    _goTo(0);
  }

  void _onSubmit() {
    dimissKeyBoard(context);
    if (_currentStep == 0 && isMainValid) {
      _goTo(1);
      return;
    }
    if (_currentStep == 1 && isMainValid && isExtendValid) {
      _goTo(2);
      return;
    }
    _showNotice('You should fill all field of sign up form');
  }

  bool get isMainValid {
    valids[_ValidStep.main] = mainStep.currentState?.validate() ?? false;
    return valids[_ValidStep.main]!;
  }

  bool get isExtendValid {
    valids[_ValidStep.extend] = extendStep.currentState?.validate() ?? false;
    return valids[_ValidStep.extend]!;
  }
}

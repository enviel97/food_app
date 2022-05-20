import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/views/auth/helpers/validation.dart';

import 'package:food_shop/widgets/images/picker_avatar.dart';
import 'package:food_shop/widgets/input/custom_date_picker.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

import '../widgets/gender_radios.dart';

class ExtendInfoStep extends StatelessWidget {
  final void Function(File? images) onAvatarChange;
  final void Function(Gender? gender) onGenderChange;
  final TextEditingController birth, name;
  final Gender currentGender;
  final GlobalKey<FormState> extendStep;

  const ExtendInfoStep(
    this.extendStep, {
    required this.onAvatarChange,
    required this.onGenderChange,
    required this.currentGender,
    required this.birth,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: extendStep,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PickerAvatar(
                gender: currentGender,
                size: Dimensions.kWidth * 0.3,
                onChanged: onAvatarChange,
              ),
            ),
            Spacing.horizantal.sm,
            Expanded(
              child: GenderRadios(
                initValue: currentGender,
                onSelectRadio: onGenderChange,
              ),
            ),
          ],
        ),
        Spacing.vertical.m,
        KTextInput(
          controller: name,
          label: 'Name',
          icon: Icons.person,
          onValidation: const Validation('Name').require,
        ),
        Spacing.vertical.m,
        KDatePicker(
          maxDate: DateTime.now(),
          onValidation: const Validation('Birth').require,
          hintText: 'Birth',
          controller: birth,
        ),
      ]),
    );
  }
}

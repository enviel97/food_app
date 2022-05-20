import 'package:flutter/material.dart';
import 'package:food_shop/extentions/string.extension.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/widgets/texts/body_text.dart';

class GenderRadios extends StatefulWidget {
  final void Function(Gender? gender) onSelectRadio;
  final Gender? initValue;
  const GenderRadios({
    required this.onSelectRadio,
    Key? key,
    this.initValue,
  }) : super(key: key);

  @override
  State<GenderRadios> createState() => _GenderRadioStates();
}

class _GenderRadioStates extends State<GenderRadios> {
  late Gender? _gender;

  @override
  void initState() {
    super.initState();
    _gender = widget.initValue ?? Gender.private;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (Gender gender in Gender.values.reversed)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BodyText(
                gender.name.firstUperCase,
                fontWeight: FontWeight.bold,
              ),
              Radio<Gender>(
                value: gender,
                groupValue: _gender,
                onChanged: _onRadioSelected,
                activeColor: kTertiaryColor,
                focusColor: kTertiaryColor,
              ),
            ],
          ),
      ],
    );
  }

  void _onRadioSelected(Gender? value) {
    _gender = value;
    widget.onSelectRadio(_gender!);
    if (mounted) setState(() {});
  }
}

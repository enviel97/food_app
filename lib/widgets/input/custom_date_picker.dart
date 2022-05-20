import 'package:flutter/material.dart';
import 'package:food_shop/extentions/data_time.extension.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/input/custom_text_input.dart';

class KDatePicker extends StatefulWidget {
  final String hintText;
  final bool isClearButton;
  final DateTime? initDate;
  final String formatDate;
  final Function(DateTime? date)? onChanged;
  final DateTime? minDate;
  final DateTime? maxDate;
  final String? Function(String? value)? onValidation;
  final TextEditingController controller;

  const KDatePicker({
    required this.hintText,
    required this.controller,
    Key? key,
    this.isClearButton = true,
    this.initDate,
    this.formatDate = 'dd-MM-yyyy',
    this.minDate,
    this.maxDate,
    this.onValidation,
    this.onChanged,
  }) : super(key: key);

  @override
  _KDatePickerState createState() => _KDatePickerState();
}

class _KDatePickerState extends State<KDatePicker> {
  late DateTime? value;
  DateTime? selectedDateTime;
  String? errorText;

  @override
  void initState() {
    super.initState();
    value = widget.initDate;
    selectedDateTime = value ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectedDatePicker,
      child: Stack(
        alignment: Alignment.center,
        children: [
          KTextInput(
            controller: widget.controller,
            label: widget.hintText,
            icon: Icons.date_range_rounded,
            onValidation: widget.onValidation,
            readOnly: true,
            enabled: false,
            isShowClearButton: false,
          ),
          _buildClearButton()
        ],
      ),
    );
  }

  Widget _buildClearButton() {
    if (!widget.isClearButton || widget.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return Align(
      alignment: Alignment.centerRight,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: IconButton(
            icon: const Icon(Icons.highlight_remove_outlined),
            color: kPlaceholderSuperDarkColor,
            splashColor: kBlackColor,
            highlightColor: kBlackColor,
            onPressed: () {
              if (mounted) {
                setState(() {
                  widget.controller.clear();
                });
              }
            }),
      ),
    );
  }

  Future<void> _selectedDatePicker() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime ?? DateTime.now(),
        firstDate: widget.minDate ?? DateTime(1700),
        lastDate: widget.maxDate ?? DateTime(2500),
        initialEntryMode: DatePickerEntryMode.calendar,
        helpText: widget.hintText,
        cancelText: 'Cancel',
        confirmText: 'Set',
        fieldHintText: widget.formatDate,
        builder: (_, __) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: kTertiaryColor,
                    onPrimary: kWhiteColor,
                    onSurface: kBlackColor,
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: kTertiaryColor, // button text color
                  textStyle: TextStyle(
                      fontSize: Spacing.m.h, fontWeight: FontWeight.bold),
                ),
              ),
              dialogBackgroundColor: kPlaceholderLightColor,
            ),
            child: SizedBox.shrink(child: __),
          );
        });

    if (picked != null && picked != selectedDateTime) {
      widget.onChanged?.call(picked);
      widget.controller.text = picked.withFormat(format: widget.formatDate);
      setState(() {});
    }
  }
}

import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/models/user.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/spacing.dart';
import 'package:food_shop/widgets/texts/body_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickerAvatar extends StatefulWidget {
  final Gender gender;
  final double size;
  final void Function(File? image) onChanged;
  const PickerAvatar({
    required this.onChanged,
    this.size = 100.0,
    this.gender = Gender.private,
    Key? key,
  }) : super(key: key);

  @override
  State<PickerAvatar> createState() => _PickerAvatarState();
}

class _PickerAvatarState extends State<PickerAvatar> {
  File? image;

  // @override
  // void didUpdateWidget(PickerAvatar oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.gender != widget.gender) {
  //     setState(() {});
  //   }
  // }

  Widget defaultAvatar(double size) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: kWhiteColor),
      child: Image.asset(
        'assets/images/${widget.gender.name}.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  Widget _build(double size) {
    if (image == null) {
      return defaultAvatar(size);
    }
    return Image.file(
      image!,
      height: size,
      width: size,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => defaultAvatar(size),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size.h;
    return GestureDetector(
      onTap: _onPickPicture,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          boxShadow: [
            BoxShadow(
              color: kSecondaryColor.withOpacity(0.4),
              blurRadius: 10.0,
            )
          ],
        ),
        width: size,
        height: size,
        alignment: Alignment.center,
        child: Badge(
          showBadge: true,
          badgeContent: const Icon(
            Icons.add_a_photo_rounded,
            color: kSecondaryColor,
          ),
          position: BadgePosition.bottomEnd(bottom: 0, end: 0),
          badgeColor: kPlaceholderSuperDarkColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: _build(size),
          ),
        ),
      ),
    );
  }

  Widget _buttonTextBuilder(
    String text, {
    required Function() onPressed,
    required IconData icon,
  }) =>
      TextButton(
          onPressed: onPressed,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: kTertiaryColor),
                Spacing.horizantal.m,
                Expanded(
                    child: BodyText(text,
                        fontWeight: FontWeight.bold,
                        color: kBlackColor,
                        fontSize: 18.0.h))
              ]));

  void showSnackBar(String message) {
    if (Get.isSnackbarOpen) return;
    Get.snackbar('Error', message,
        backgroundColor: kErrorColor.withOpacity(.6), colorText: kWhiteColor);
  }

  Future<void> _onPickPicture() async {
    final image = await Get.bottomSheet<File?>(
      Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buttonTextBuilder('Photo library',
                icon: Icons.photo_library_rounded, onPressed: _pickImage),
            _buttonTextBuilder('Take a photos',
                icon: Icons.add_a_photo_rounded, onPressed: _takePicture)
          ])),
      backgroundColor: kLightBackgoundColor,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.h)),
      ),
    );

    if (image == null) return;
    widget.onChanged(image);
    setState(() => this.image = image);
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        Get.back(result: null);
        return;
      }

      final imageTemp = File(image.path);

      Get.back(result: imageTemp);
    } on PlatformException catch (e) {
      debugPrint('$e');
      showSnackBar('Get image failed');
      Get.back(result: null);
    }
  }

  Future<void> _takePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        Get.back(result: null);
        return;
      }

      final imageTemp = File(image.path);

      Get.back(result: imageTemp);
    } on PlatformException catch (e) {
      debugPrint('$e');
      showSnackBar('Take a image photos failed');
      Get.back(result: null);
    }
  }
}

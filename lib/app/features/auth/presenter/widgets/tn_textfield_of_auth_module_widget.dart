import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNTextfieldOfAuthModuleWidget extends StatelessWidget {
  const TNTextfieldOfAuthModuleWidget({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    required this.enabledBorderColor,
    required this.obscureText,
    this.onPressedInVisibilityButton,
    this.hintText,
    this.textInputAction,
    this.onEditingComplete,
    required this.focusedBorderColor,
    this.isExtended,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final bool obscureText;
  final bool? isExtended;
  final Function()? onPressedInVisibilityButton;
  final Function()? onEditingComplete;
  final String? hintText;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: AppColors.black,
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        maxLines: isExtended == true ? 20 : 1,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor, width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.black,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(suffixIcon),
              color: AppColors.black,
              onPressed: onPressedInVisibilityButton,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.black,
            fontSize: 18.r,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: TextStyle(
          color: AppColors.black,
          fontSize: 18.r,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

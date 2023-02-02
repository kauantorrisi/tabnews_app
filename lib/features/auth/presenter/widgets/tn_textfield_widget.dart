import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNTextField extends StatelessWidget {
  const TNTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    required this.enabledBorderColor,
    required this.obscureText,
    this.onPressedInVisibilityButton,
    required this.hintText,
    required this.textInputAction,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Color enabledBorderColor;
  final bool obscureText;
  final Function()? onPressedInVisibilityButton;
  final Function()? onEditingComplete;
  final String hintText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: AppColors.black,
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        maxLines: 1,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor, width: 2),
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black, width: 2),
            borderRadius: BorderRadius.circular(50.0),
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

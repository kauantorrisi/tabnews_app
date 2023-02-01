import 'package:flutter/material.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNTextField extends StatelessWidget {
  const TNTextField({
    super.key,
    required this.controller,
    required this.icon,
  });

  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blue,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNErrorMessageWidget extends StatelessWidget {
  const TNErrorMessageWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        message,
        style: TextStyle(
          color: AppColors.red.withBlue(80),
          fontWeight: FontWeight.w600,
          fontSize: 14.r,
        ),
      ),
    );
  }
}

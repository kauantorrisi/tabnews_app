import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNAlertDialogWidget extends StatelessWidget {
  const TNAlertDialogWidget({
    super.key,
    required this.userEmail,
    required this.textContent,
  });

  final String userEmail;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.darkGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      title: Text(
        'Cheque o seu e-mail: $userEmail',
        style: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.r,
        ),
      ),
      content: Text(
        textContent,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 15.r,
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Okay'),
          onPressed: () => Modular.to.pop(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNUserFAB extends StatelessWidget {
  const TNUserFAB({super.key, required this.onPressed, this.icon});

  final Function()? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.darkGrey,
      child: Icon(icon, size: 35),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNAppBarWidget extends StatelessWidget {
  const TNAppBarWidget({
    super.key,
    required this.paddingHorizontal,
  });

  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkGrey,
      title: Row(
        children: [
          Image.asset('lib/assets/images/TabNewsIcon.png', height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal.w),
            child: Text(
              'TabNews',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

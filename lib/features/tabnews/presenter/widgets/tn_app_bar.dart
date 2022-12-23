import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNAppBar extends StatefulWidget {
  const TNAppBar({super.key});

  @override
  State<TNAppBar> createState() => _TNAppBarState();
}

class _TNAppBarState extends State<TNAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(color: AppColors.darkGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.asset('lib/assets/images/TabNews_Logo.png'),
            const Spacer(),
            Text(
              'TabNews',
              style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 24),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TNButtonWidget extends StatelessWidget {
  const TNButtonWidget({
    super.key,
    this.onTap,
    required this.color,
    required this.widget,
    required this.margin,
  });

  final Function()? onTap;
  final Color color;
  final Widget widget;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}

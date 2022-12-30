import 'package:flutter/material.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNBottomNavigationBar extends StatelessWidget {
  const TNBottomNavigationBar({
    super.key,
    required this.onPressedInRelevantButton,
    required this.onPressedInRecentButton,
    this.colorRelevantIcon,
    this.colorRecentIcon,
  });

  final Function()? onPressedInRelevantButton;
  final Function()? onPressedInRecentButton;
  final Color? colorRelevantIcon;
  final Color? colorRecentIcon;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 5,
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      color: AppColors.darkGrey,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: onPressedInRelevantButton,
                icon: Icon(
                  Icons.bar_chart_rounded,
                  size: 35,
                  color: colorRelevantIcon,
                ),
              ),
              const Spacer(flex: 4),
              IconButton(
                onPressed: onPressedInRecentButton,
                icon: Icon(
                  Icons.access_time_rounded,
                  size: 35,
                  color: colorRecentIcon,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNBottomNavigationBar extends StatelessWidget {
  const TNBottomNavigationBar({
    super.key,
    required this.onPressedInRelevantButton,
    required this.onPressedInRecentButton,
    this.colorRelevantIcon,
    this.colorRecentIcon,
    this.colorSavedIcon,
    required this.haveIconToNavigateOfTabsSaved,
    this.onPressedInSavedTabsButton,
  });

  final Function()? onPressedInRelevantButton;
  final Function()? onPressedInRecentButton;
  final Function()? onPressedInSavedTabsButton;
  final Color? colorRelevantIcon;
  final Color? colorRecentIcon;
  final Color? colorSavedIcon;
  final bool haveIconToNavigateOfTabsSaved;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      shape: const CircularNotchedRectangle(),
      color: AppColors.darkGrey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Spacer(),
            IconButton(
              onPressed: onPressedInRelevantButton,
              icon: Icon(
                Icons.bar_chart_rounded,
                size: 30,
                color: colorRelevantIcon,
              ),
            ),
            const Spacer(flex: 2),
            IconButton(
              onPressed: onPressedInRecentButton,
              icon: Icon(
                Icons.access_time_rounded,
                size: 30,
                color: colorRecentIcon,
              ),
            ),
            if (haveIconToNavigateOfTabsSaved) const Spacer(flex: 2),
            if (haveIconToNavigateOfTabsSaved)
              IconButton(
                onPressed: onPressedInSavedTabsButton,
                icon: Icon(
                  Icons.bookmark,
                  size: 30,
                  color: colorSavedIcon,
                ),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

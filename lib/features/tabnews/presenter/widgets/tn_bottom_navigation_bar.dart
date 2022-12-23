import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNBottomNavigationBar extends StatelessWidget {
  TNBottomNavigationBar({
    super.key,
    required this.onPressedInRelevantButton,
    required this.onPressedInRecentButton,
    this.colorRevelantIcon,
    this.colorRecentIcon,
  });

  final Function()? onPressedInRelevantButton;
  final Function()? onPressedInRecentButton;
  final Color? colorRevelantIcon;
  final Color? colorRecentIcon;

  final TabnewsCubit cubit = Modular.get<TabnewsCubit>();

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
                  color: colorRevelantIcon,
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

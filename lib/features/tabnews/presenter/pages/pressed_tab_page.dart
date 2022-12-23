import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';

import 'package:tabnews_app/features/tabnews/presenter/widgets/tn_app_bar.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class PressedTabPage extends StatelessWidget {
  const PressedTabPage({super.key, required this.cubit});

  final TabnewsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TNAppBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Modular.to.pop(),
                  icon: Icon(Icons.arrow_back, color: AppColors.white),
                ),
                const Spacer(),
                Text(
                  cubit.pressedTab.title,
                  style: TextStyle(color: AppColors.white, fontSize: 14),
                ),
                const Spacer(),
              ],
            ),
            Text(cubit.pressedTab.body.toString(),
                style: TextStyle(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}

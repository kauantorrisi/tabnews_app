import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNMenuFAB extends StatelessWidget {
  const TNMenuFAB({
    super.key,
    required this.onPressed,
    this.icon,
    required this.hawkFabMenuController,
    this.iconColor,
    required this.username,
  });

  final Function()? onPressed;
  final AnimatedIconData? icon;
  final HawkFabMenuController hawkFabMenuController;
  final Color? iconColor;
  final String username;

  @override
  Widget build(BuildContext context) {
    return HawkFabMenu(
      icon: icon,
      fabColor: AppColors.blue.withAlpha(220),
      iconColor: iconColor,
      hawkFabMenuController: hawkFabMenuController,
      items: [
        HawkFabMenuItem(
          label: username,
          ontap: () {},
          icon: const Icon(Icons.home),
          color: AppColors.darkGrey,
          labelColor: AppColors.black,
          labelBackgroundColor: AppColors.white,
        ),
        HawkFabMenuItem(
          label: 'Publicar novo conteúdo',
          ontap: () => Modular.to.pushNamed('/tabs-module/post-tab-page'),
          icon: const Icon(Icons.article),
          color: AppColors.darkGrey,
          labelColor: AppColors.black,
          labelBackgroundColor: AppColors.white,
        ),
        HawkFabMenuItem(
          label: 'Editar perfil',
          ontap: () {},
          icon: const Icon(Icons.person),
          color: AppColors.darkGrey,
          labelColor: AppColors.black,
          labelBackgroundColor: AppColors.white,
        ),
        HawkFabMenuItem(
          label: 'Configurações',
          ontap: () {},
          icon: const Icon(Icons.settings),
          color: AppColors.darkGrey,
          labelColor: AppColors.black,
          labelBackgroundColor: AppColors.white,
        ),
        HawkFabMenuItem(
          label: 'Deslogar',
          ontap: () {
            Modular.to.pushReplacementNamed(Modular.initialRoute);
          },
          icon: const Icon(Icons.exit_to_app),
          color: AppColors.red,
          labelColor: AppColors.black,
          labelBackgroundColor: AppColors.white,
        ),
      ],
      body: Container(),
    );
  }
}

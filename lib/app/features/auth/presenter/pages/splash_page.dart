import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabnews_app/app/features/auth/services/auth_prefs_service.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.wait([
      AuthPrefsService().isAuth(),
      Future.delayed(const Duration(seconds: 3)),
    ]).then((value) => value[0]
        ? Modular.to.pushReplacementNamed('/tabs-module/', arguments: {
            "token": AuthPrefsService.token,
            "username": AuthPrefsService.username,
            "tabcoins": AuthPrefsService.tabCoins,
            "tabcash": AuthPrefsService.tabCash,
            "isGuest": AuthPrefsService.isGuest,
          })
        : Modular.to.pushReplacementNamed('/auth-module/login-page'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Text(
                    'TabNews',
                    style: TextStyle(
                      fontSize: 100,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    'with Flutter',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'Made with ❤️ by KauanTorrisi',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

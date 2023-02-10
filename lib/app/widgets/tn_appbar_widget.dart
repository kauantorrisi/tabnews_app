import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TNAppBarWidget extends StatelessWidget {
  const TNAppBarWidget({
    super.key,
    required this.haveImage,
    required this.haveCoins,
    this.tabCoins,
    this.tabCash,
  });
  final bool haveImage;
  final bool haveCoins;
  final int? tabCoins;
  final int? tabCash;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkGrey,
      leading: haveImage
          ? Image.asset('lib/assets/images/TabNewsIcon.png', height: 24)
          : IconButton(
              onPressed: () => Modular.to.pop(),
              icon: const Icon(Icons.arrow_back),
            ),
      title: Row(
        children: [
          Padding(
            padding: haveCoins
                ? EdgeInsets.only(right: 81.w, left: 81.w)
                : const EdgeInsets.all(0),
            child: Text(
              'TabNews',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (haveCoins)
            _tabCoinsAndCash(
                color: AppColors.blue, tabCoinsOrTabCash: tabCoins),
          if (haveCoins)
            _tabCoinsAndCash(
                color: AppColors.green, tabCoinsOrTabCash: tabCash),
        ],
      ),
    );
  }

  Widget _tabCoinsAndCash(
      {required Color color, required int? tabCoinsOrTabCash}) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            tabCoinsOrTabCash.toString(),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}

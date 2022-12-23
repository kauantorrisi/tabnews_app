import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';
import 'package:tabnews_app/features/tabnews/presenter/widgets/tn_app_bar.dart';
import 'package:tabnews_app/features/tabnews/presenter/widgets/tn_bottom_navigation_bar.dart';
import 'package:tabnews_app/features/tabnews/presenter/widgets/tn_user_fab.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class RevelantTabsPage extends StatefulWidget {
  const RevelantTabsPage({super.key});

  @override
  State<RevelantTabsPage> createState() => _RevelantTabsPageState();
}

class _RevelantTabsPageState extends State<RevelantTabsPage> {
  final cubit = Modular.get<TabnewsCubit>();

  @override
  void initState() {
    cubit.getRevelantTabs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return BlocBuilder<TabnewsCubit, TabnewsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state == TabNewsLoading()) {
            return _screenBody(cubit.revelantTabsList, state);
          } else if (state == TabNewsError()) {
            return const Center(child: Text('INTERNAL ERROR'));
          } else if (state == TabNewsSuccessful() &&
              cubit.isInRevelantPage == true) {
            return _screenBody(cubit.revelantTabsList, state);
          } else if (state == TabNewsSuccessful() &&
              cubit.isInRevelantPage == false) {
            return _screenBody(cubit.recentTabsList, state);
          } else {
            return Container();
          }
        },
      );
    });
  }

  Widget _screenBody(List<TabEntity> tabsList, TabnewsState state) {
    return SafeArea(
      child: state == TabNewsLoading()
          ? SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.grey,
                body: Column(
                  children: const [
                    TNAppBar(),
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: TNUserFAB(
                  icon: Icons.person,
                  onPressed: () {},
                ),
                bottomNavigationBar: TNBottomNavigationBar(
                  onPressedInRelevantButton: () {
                    cubit.isInRevelantPage = true;
                    cubit.getRevelantTabs();
                  },
                  colorRevelantIcon: cubit.isInRevelantPage == true
                      ? AppColors.blue
                      : AppColors.white,
                  onPressedInRecentButton: () {
                    cubit.isInRevelantPage = false;
                    cubit.getRecentTabs();
                  },
                  colorRecentIcon: cubit.isInRevelantPage == false
                      ? AppColors.blue
                      : AppColors.white,
                ),
              ),
            )
          : Scaffold(
              backgroundColor: AppColors.grey,
              body: Column(
                children: [
                  const TNAppBar(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tabsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    '${index + 1}. ${tabsList[index].title}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        '${tabsList[index].tabcoins} tabcoins • ',
                                    style:
                                        TextStyle(color: AppColors.lightGrey),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${tabsList[index].childrenDeepCount} comentários • ',
                                      ),
                                      TextSpan(
                                        text: tabsList[index].ownerUsername,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: TNUserFAB(
                icon: Icons.person,
                onPressed: () {},
              ),
              bottomNavigationBar: TNBottomNavigationBar(
                onPressedInRelevantButton: () {
                  cubit.isInRevelantPage = true;
                  cubit.getRevelantTabs();
                },
                colorRevelantIcon: cubit.isInRevelantPage == true
                    ? AppColors.blue
                    : AppColors.white,
                onPressedInRecentButton: () {
                  cubit.isInRevelantPage = false;
                  cubit.getRecentTabs();
                },
                colorRecentIcon: cubit.isInRevelantPage == false
                    ? AppColors.blue
                    : AppColors.white,
              ),
            ),
    );
  }
}

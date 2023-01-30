import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:tabnews_app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabs/presenter/cubits/tabs_cubit.dart';
import 'package:tabnews_app/features/tabs/presenter/widgets/tn_bottom_navigation_bar.dart';
import 'package:tabnews_app/features/tabs/presenter/widgets/tn_user_fab.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final cubit = Modular.get<TabsCubit>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return BlocBuilder<TabsCubit, TabsState>(
        bloc: cubit,
        builder: (context, state) {
          final List<TabEntity> tabList = cubit.isInRelevantPage == true
              ? cubit.relevantTabsList
              : cubit.recentTabsList;

          return LazyLoadScrollView(
            onEndOfPage: () {
              cubit.isInRelevantPage == true
                  ? cubit.loadMoreRelevantTabs()
                  : cubit.loadMoreRecentTabs();
            },
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => cubit.isInRelevantPage == true
                    ? cubit.getRelevantTabs()
                    : cubit.getRecentTabs(),
                child: Scaffold(
                  extendBody: true,
                  backgroundColor: AppColors.grey,
                  body: Column(
                    children: [
                      _tNAppBar(
                        Text(
                          'TabNews',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      if (state is TabsLoaded)
                        Expanded(
                          child: ListView.builder(
                            itemCount: tabList.length,
                            itemBuilder: (context, index) {
                              return _tabCard(tabList, index);
                            },
                          ),
                        ),
                      if (state is TabsLoading)
                        const Center(
                          child: LinearProgressIndicator(),
                        ),
                      if (state is TabsError)
                        const Center(
                          child: Text('ERROR'),
                        ),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: TNUserFAB(
                    icon: Icons.person,
                    onPressed: () {},
                  ),
                  bottomNavigationBar: _tNBottomNavigationBar(),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _tNAppBar(Widget text) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(color: AppColors.darkGrey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () =>
                  Modular.to.pushReplacementNamed(Modular.initialRoute),
              child: Image.asset('lib/assets/images/TabNews_Logo.png'),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: text,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _tabCard(List<TabEntity> tabsList, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await cubit.getTab(index: index);
          await cubit.getTabComments();
          Modular.to.pushNamed(
            '/pressed-tab-page',
            arguments: cubit,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${index + 1}. ${tabsList[index].title}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
              RichText(
                text: TextSpan(
                  text: '${tabsList[index].tabcoins} tabcoins • ',
                  style: TextStyle(color: AppColors.lightGrey),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tNBottomNavigationBar() {
    return TNBottomNavigationBar(
      onPressedInRelevantButton: () async {
        cubit.isInRelevantPage = true;
        await cubit.getRelevantTabs();
      },
      colorRelevantIcon:
          cubit.isInRelevantPage == true ? AppColors.blue : AppColors.white,
      onPressedInRecentButton: () async {
        cubit.isInRelevantPage = false;
        await cubit.getRecentTabs();
      },
      colorRecentIcon:
          cubit.isInRelevantPage == false ? AppColors.blue : AppColors.white,
    );
  }
}

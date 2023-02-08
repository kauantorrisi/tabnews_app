import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubit/tabs_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_bottom_navigation_bar.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_user_fab.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({
    super.key,
    required this.token,
    required this.username,
    required this.tabCoins,
    required this.tabCash,
    required this.isGuest,
  });

  final String token;
  final String username;
  final int tabCoins;
  final int tabCash;
  final bool isGuest;

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final cubit = Modular.get<TabsCubit>();

  @override
  void initState() {
    cubit.getAllTabs();
    super.initState();
  }

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
            onEndOfPage: () async {
              await cubit.loadMoreTabs();
              setState(() {});
            },
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => cubit.getAllTabs(),
                child: Scaffold(
                  backgroundColor: AppColors.grey,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: TNAppBarWidget(
                      haveImage: widget.isGuest ? false : true,
                      haveCoins: widget.isGuest ? false : true,
                      tabCoins: widget.tabCoins,
                      tabCash: widget.tabCash,
                    ),
                  ),
                  body: Column(
                    children: [
                      if (state is TabsLoaded)
                        Expanded(
                          child: ListView.builder(
                            itemCount: tabList.length,
                            itemBuilder: (context, index) {
                              return _tabCard(tabList, index);
                            },
                          ),
                        ),
                      if (state is TabsLoading) const LinearProgressIndicator(),
                      if (state is TabsError)
                        const Text('ERROR'), // TODO Melhorar tela de erro.
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: widget.isGuest
                      ? null
                      : TNMenuFAB(
                          username: widget.username,
                          icon: AnimatedIcons.list_view,
                          iconColor: AppColors.white,
                          hawkFabMenuController: cubit.hawkFabMenuController,
                          onPressed: () {
                            cubit.hawkFabMenuController.toggleMenu();
                          },
                        ),
                  bottomNavigationBar: TNBottomNavigationBar(
                    haveIconToNavigateOfTabsSaved:
                        widget.isGuest ? false : true,
                    onPressedInRelevantButton: () async {
                      if (state is TabsLoading) {
                        return;
                      } else {
                        cubit.toggleIsInRelevantPage(true);
                        await cubit.getAllTabs();
                      }
                    },
                    colorRelevantIcon: cubit.isInRelevantPage == true
                        ? AppColors.blue
                        : AppColors.white,
                    onPressedInRecentButton: () async {
                      if (state is TabsLoading) {
                        return;
                      } else {
                        cubit.toggleIsInRelevantPage(false);
                        await cubit.getAllTabs();
                      }
                    },
                    colorRecentIcon: cubit.isInRelevantPage == false
                        ? AppColors.blue
                        : AppColors.white,
                    colorSaveIcon: AppColors
                        .white, // TODO ajustar cor se estiver na página dos tabs salvos
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _tabCard(List<TabEntity> tabsList, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          await cubit.getTab(index: index);
          await cubit.getTabComments();
          Modular.to.pushNamed(
            '/tabs-module/pressed-tab-page',
            arguments: {
              "cubit": cubit,
              "tabCoins": widget.tabCoins,
              "tabCash": widget.tabCash,
              "token": widget.token,
              "isGuest": widget.isGuest,
            },
          );
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tabsList[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
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
                          text: '${tabsList[index].ownerUsername} • ',
                        ),
                        const TextSpan(
                          text:
                              'há algum tempo', // TODO adicionar há quanto tempo em que o tab foi publicado
                        ),
                      ],
                    ),
                  ),
                  _divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: AppColors.lightGrey,
      width: 500.w,
      height: 1.5,
    );
  }
}

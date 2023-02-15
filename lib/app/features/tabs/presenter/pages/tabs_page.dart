import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubits/tabsPage/tabs_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_bottom_navigation_bar.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_user_fab.dart';
import 'package:tabnews_app/app/features/tabs/services/tabs_prefs_service.dart';
import 'package:tabnews_app/app/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({
    super.key,
    required this.token,
    required this.isGuest,
  });

  final String token;
  final bool isGuest;

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final cubit = Modular.get<TabsCubit>();

  @override
  void initState() {
    cubit.getAllTabs();
    cubit.getUser(widget.token);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cubit.getAllTabs();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, _) {
      return BlocBuilder<TabsCubit, TabsState>(
        bloc: cubit,
        builder: (context, state) {
          return LazyLoadScrollView(
            onEndOfPage: () async {
              await cubit.loadMoreTabs();
              setState(() {});
            },
            child: RefreshIndicator(
              onRefresh: () => cubit.getAllTabs(),
              child: Scaffold(
                backgroundColor: AppColors.grey,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: TNAppBarWidget(
                    haveImage: widget.isGuest ? false : true,
                    haveCoins: widget.isGuest ? false : true,
                    tabCoins: cubit.userEntity?.tabcoins ?? 0,
                    tabCash: cubit.userEntity?.tabcash ?? 0,
                  ),
                ),
                body: Column(
                  children: [
                    if (state is TabsInitial)
                      Expanded(
                        child: ListView.builder(
                          itemCount: cubit.isInSavedTabsPage == true
                              ? cubit.savedTabsList.length
                              : cubit.tabsList.length,
                          itemBuilder: (context, index) {
                            return _tabCard(
                                cubit.isInSavedTabsPage == true
                                    ? cubit.savedTabsList
                                    : cubit.tabsList,
                                index);
                          },
                        ),
                      ),
                    if (state is TabsLoading) const LinearProgressIndicator(),
                    if (state is TabsError) _errorMessage(),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: widget.isGuest
                    ? null
                    : TNMenuFAB(
                        token: widget.token,
                        username: cubit.userEntity?.username ?? 'Username',
                        icon: AnimatedIcons.list_view,
                        iconColor: AppColors.white,
                        hawkFabMenuController: cubit.hawkFabMenuController,
                        tabCoins: cubit.userEntity?.tabcoins ?? 0,
                        tabCash: cubit.userEntity?.tabcash ?? 0,
                        savedTabsList: cubit.savedTabsList,
                        onPressed: () {
                          cubit.hawkFabMenuController.toggleMenu();
                        },
                      ),
                bottomNavigationBar: TNBottomNavigationBar(
                  haveIconToNavigateOfTabsSaved: widget.isGuest ? false : true,
                  onPressedInRelevantButton: () async {
                    if (state is TabsLoading) {
                      return;
                    } else {
                      cubit.toggleIsInRelevantPage(true);
                      cubit.toggleIsInSavedTabsPage(false);
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
                      cubit.toggleIsInSavedTabsPage(false);
                      await cubit.getAllTabs();
                    }
                  },
                  onPressedInSavedTabsButton: () async {
                    if (state is TabsLoading) {
                      return;
                    } else {
                      cubit.toggleIsInRelevantPage(false);
                      cubit.toggleIsInSavedTabsPage(true);
                      setState(() {});
                    }
                  },
                  colorRecentIcon: cubit.isInRelevantPage == false &&
                          cubit.isInSavedTabsPage == false
                      ? AppColors.blue
                      : AppColors.white,
                  colorSavedIcon: cubit.isInSavedTabsPage
                      ? AppColors.blue
                      : AppColors.white,
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

  Widget _errorMessage() {
    return AlertDialog(
      title: Text(
        'Ocorreu um erro interno no APP, por favor tente novamente!',
        style: TextStyle(color: AppColors.white),
      ),
      backgroundColor: AppColors.black,
    );
  }
}

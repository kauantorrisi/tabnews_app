import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:tabnews_app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabs/presenter/cubit/tabs_cubit.dart';
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
  void initState() {
    // TODO VER SE RESOLVEU ERRO DE VOLTAR E Não CARREGAR PELO BOTAO DO SISTEMA ANDROID.
    cubit.getRelevantTabs();
    cubit.getRecentTabs();
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
                  backgroundColor: AppColors.grey,
                  body: Column(
                    children: [
                      _tNAppBar(
                        Text(
                          'TabNews',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
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
                      if (state is TabsLoading) const LinearProgressIndicator(),
                      if (state is TabsError) const Text('ERROR'),
                    ],
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: TNMenuFAB(
                    icon: AnimatedIcons.list_view,
                    iconColor: AppColors.white,
                    hawkFabMenuController: cubit.hawkFabMenuController,
                    onPressed: () {
                      cubit.hawkFabMenuController.toggleMenu();
                    },
                  ),
                  bottomNavigationBar: TNBottomNavigationBar(
                    onPressedInRelevantButton: () async {
                      await cubit.getRelevantTabs();
                    },
                    colorRelevantIcon: cubit.isInRelevantPage == true
                        ? AppColors.blue
                        : AppColors.white,
                    onPressedInRecentButton: () async {
                      await cubit.getRecentTabs();
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
              child: Image.asset('lib/assets/images/TabNewsIcon.png'),
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
            '/tabs-module/pressed-tab-page',
            arguments: cubit,
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
      width: 500,
      height: 1.5,
    );
  }
}

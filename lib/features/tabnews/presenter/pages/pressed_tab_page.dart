import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PressedTabPage extends StatelessWidget {
  const PressedTabPage({super.key, required this.cubit});

  final TabnewsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.grey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tNAppBar(
              SizedBox(
                width: 200.w,
                child: Text(
                  cubit.pressedTab.title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            _ownerOfTab(),
            _bodyOfTab(),
            // _commentsOfTab(),
            _bottomStatusBar(),
          ],
        ),
      ),
    );
  }

  Widget _tNAppBar(Widget text) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(color: AppColors.darkGrey),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Modular.to.pop();
              if (cubit.isInRelevantPage == true) {
                cubit.getRelevantTabs();
              } else {
                cubit.getRecentTabs();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: AppColors.white,
            ),
          ),
          const Spacer(flex: 5),
          text,
          const Spacer(flex: 5),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: AppColors.white,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _ownerOfTab() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
        ),
        child: Center(
          child: Text(
            cubit.pressedTab.ownerUsername,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyOfTab() {
    return Expanded(
      child: Markdown(
        selectable: true,
        data: cubit.pressedTab.body.toString(),
        onTapLink: (text, href, title) {
          if (href != null) {
            launchUrl(Uri.parse(href.toString()));
          }
        },
        styleSheet: MarkdownStyleSheet(
          a: TextStyle(color: AppColors.blue, fontSize: 16),
          h1: TextStyle(color: AppColors.white, fontSize: 28),
          h2: TextStyle(color: AppColors.white, fontSize: 26),
          h3: TextStyle(color: AppColors.white, fontSize: 24),
          h4: TextStyle(color: AppColors.white, fontSize: 22),
          h5: TextStyle(color: AppColors.white, fontSize: 20),
          h6: TextStyle(color: AppColors.white, fontSize: 18),
          p: TextStyle(color: AppColors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _commentsOfTab() {
    return Expanded(
      child: ListView.builder(
        itemCount: cubit.pressedTab.children!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.black,
                  border: Border.all(
                    color: AppColors.white,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        '${index + 1}. ${cubit.pressedTab.children![index].title}',
                        style: TextStyle(
                          fontSize: 20,
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
                            '${cubit.pressedTab.children![index].tabcoins} tabcoins • ',
                        style: TextStyle(color: AppColors.lightGrey),
                        children: [
                          TextSpan(
                            text:
                                '${cubit.pressedTab.children![index].childrenDeepCount} comentários • ',
                          ),
                          TextSpan(
                            text:
                                cubit.pressedTab.children![index].ownerUsername,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _bottomStatusBar() {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.keyboard_arrow_up,
            color: AppColors.green,
            size: 30,
          ),
        ),
        Text(
          cubit.pressedTab.tabcoins.toString(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.red,
            size: 30,
          ),
        ),
        const Spacer(flex: 2),
        Icon(Icons.chat_bubble_outline, color: AppColors.white),
        Text(
          cubit.pressedTab.childrenDeepCount.toString(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
        const Spacer(flex: 2),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, color: AppColors.white),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

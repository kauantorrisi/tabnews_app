import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabnews_app/features/tabnews/presenter/cubits/tabs_cubit.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class PressedTabPage extends StatelessWidget {
  const PressedTabPage({super.key, required this.cubit});

  final TabsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.grey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tNAppBar(),
            _ownerOfTab(),
            _bodyOfTab(),
            _commentsOfTab(),
            _bottomStatusBar(),
          ],
        ),
      ),
    );
  }

  Widget _tNAppBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(color: AppColors.darkGrey),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              if (cubit.isInRelevantPage == true) {
                await cubit.getRelevantTabs();
              } else {
                await cubit.getRecentTabs();
              }
              Modular.to.pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: AppColors.white,
            ),
          ),
          const Spacer(flex: 5),
          SizedBox(
            width: 250.w,
            child: Text(
              cubit.pressedTab.title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
      child: Column(
        children: [
          Expanded(
            child: Markdown(
              selectable: true,
              data: cubit.pressedTab.body,
              onTapLink: (text, href, title) {
                if (href != null) {
                  launchUrl(Uri.parse(href.toString()));
                }
              },
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(color: AppColors.white, fontSize: 28),
                h2: TextStyle(color: AppColors.white, fontSize: 26),
                h3: TextStyle(color: AppColors.white, fontSize: 24),
                h4: TextStyle(color: AppColors.white, fontSize: 22),
                h5: TextStyle(color: AppColors.white, fontSize: 20),
                h6: TextStyle(color: AppColors.white, fontSize: 18),
                a: TextStyle(color: AppColors.blue, fontSize: 16),
                p: TextStyle(color: AppColors.white, fontSize: 16),
                listBullet: TextStyle(color: AppColors.white, fontSize: 16),
                code: TextStyle(
                  color: AppColors.white.withAlpha(230),
                  fontSize: 16,
                  backgroundColor: AppColors.darkGrey,
                ),
                // TODO textScaleFactor adjust with the user choices in settings ,
                blockquoteDecoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
                codeblockDecoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _commentsOfTab() {
    return Expanded(
      child: ListView.builder(
        itemCount: cubit.tabComments.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 5),
                child: Text(
                  '${cubit.tabComments[index].ownerUsername}: ',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.darkGrey,
                  border: Border.all(
                    color: AppColors.white,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
                child: Text(
                  cubit.tabComments[index].body,
                  style: TextStyle(color: AppColors.white),
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

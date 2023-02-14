import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabnews_app/app/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubits/tabsPage/tabs_cubit.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class PressedTabPage extends StatefulWidget {
  const PressedTabPage({
    super.key,
    required this.cubit,
    required this.token,
    required this.isGuest,
  });

  final TabsCubit cubit;
  final String token;
  final bool isGuest;

  @override
  State<PressedTabPage> createState() => _PressedTabPageState();
}

class _PressedTabPageState extends State<PressedTabPage> {
  @override
  void dispose() {
    widget.cubit.getAllTabs();
    // TODO mover essa chamada getUser dentro do botão de enviar comentário, após realizar o comentário
    if (!widget.isGuest) {
      widget.cubit.getUser(widget.token);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.grey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TNAppBarWidget(
              haveImage: false,
              haveCoins: widget.isGuest ? false : true,
              tabCoins: widget.cubit.userTabCoins!,
              tabCash: widget.cubit.userTabCash!,
            ),
            _ownerOfTab(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _body();
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.cubit.pressedTab!.title,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20.r,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _convertTabBodyToMarkdown(data: widget.cubit.pressedTab!.body),
        _tabStatusBar(),
        _commentsOfTab(),
      ],
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
            widget.cubit.pressedTab!.ownerUsername,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _convertTabBodyToMarkdown({required String data}) {
    return Markdown(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      selectable: true,
      data: data,
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
        blockquoteDecoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        codeblockDecoration: BoxDecoration(
          color: AppColors.darkGrey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _tabStatusBar() {
    return Column(
      children: [
        if (widget.isGuest == false)
          Row(
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
                ' ${widget.cubit.pressedTab?.tabcoins}',
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
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                color: AppColors.white,
                onPressed: () {},
              ),
              Text(
                ' ${widget.cubit.pressedTab?.childrenDeepCount}',
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
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bookmark_add_outlined, color: AppColors.white),
              ),
              const Spacer(flex: 2),
            ],
          ),
        Container(
          height: 1.5.h,
          width: 500.w,
          color: AppColors.white,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _commentsOfTab() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.cubit.tabComments.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isGuest)
              Column(
                // TODO implementar upvote e downvote nos comentários
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_up),
                    color: AppColors.green,
                  ),
                  Text(
                    '${widget.cubit.tabComments[index].tabcoins}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_down),
                    color: AppColors.red,
                  ),
                ],
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 5),
                    child: GestureDetector(
                      onTap:
                          () {}, // TODO adiconar navegação para o user module -> página de perfil do usuário
                      child: Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: AppColors.blue.withAlpha(60),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          ' ${widget.cubit.tabComments[index].ownerUsername}:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.grey,
                      border: Border.all(
                        color: AppColors.white,
                        width: 1.5,
                      ),
                    ),
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: _convertTabBodyToMarkdown(
                        data: widget.cubit.tabComments[index].body),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

import 'package:tabnews_app/app/features/tabs/presenter/cubits/postTabPage/post_tab_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_text_button_widget.dart';
import 'package:tabnews_app/app/features/tabs/presenter/widgets/tn_textfield_of_post_tab_widget.dart';
import 'package:tabnews_app/app/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/widgets/tn_button_widget.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class PostTabPage extends StatelessWidget {
  PostTabPage({
    super.key,
    required this.tabCoins,
    required this.tabCash,
    required this.token,
    required this.username,
  });

  final PostTabCubit cubit = Modular.get<PostTabCubit>();

  final String token;
  final String username;
  final int tabCoins;
  final int tabCash;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.grey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TNAppBarWidget(
            haveImage: false,
            haveCoins: true,
            tabCoins: tabCoins,
            tabCash: tabCash,
          ),
        ),
        body: BlocBuilder<PostTabCubit, PostTabState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is PostTabLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostTabSuccessful) {
              return const Text('SUCESSO AO POSTAR!');
            } else if (state is PostTabError) {
              return const Text('ERROR');
            } else if (state is PostTabInitial) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'Publicar novo conteúdo',
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TNTextfieldOfPostTabWidget(
                    controller: cubit.titleController,
                    prefixIcon: Icons.title,
                    enabledBorderColor: AppColors.lightGrey,
                    obscureText: false,
                    hintText: 'Título',
                    textInputAction: TextInputAction.next,
                    focusedBorderColor: AppColors.blue,
                  ),
                  _actionsRowAndMarkdownTextInput(),
                  TNTextfieldOfPostTabWidget(
                    controller: cubit.sourceUrlController,
                    enabledBorderColor: AppColors.lightGrey,
                    prefixIcon: Icons.link,
                    obscureText: false,
                    hintText: 'Fonte (opcional)',
                    textInputAction: TextInputAction.done,
                    focusedBorderColor: AppColors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TNButtonWidget(
                        onTap: () => Modular.to.pop(),
                        color: AppColors.white,
                        widget: const Text('Cancelar'),
                        margin: const EdgeInsets.only(top: 40),
                      ),
                      TNButtonWidget(
                        onTap: () =>
                            cubit.postTab(token: token, username: username),
                        color: AppColors.green,
                        widget: const Text('Publicar'),
                        margin: const EdgeInsets.only(top: 40),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _actionsRowAndMarkdownTextInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Container(
            height: 40,
            width: 360.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TNTextButtonWidget(
                  text: 'Escrever',
                  color: AppColors.grey,
                ),
                TNTextButtonWidget(
                  text: 'Visualizar',
                  color: AppColors.grey,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen),
                ),
              ],
            ),
          ),
          MarkdownTextInput(
            () {},
            '',
            controller: cubit.bodyController,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}

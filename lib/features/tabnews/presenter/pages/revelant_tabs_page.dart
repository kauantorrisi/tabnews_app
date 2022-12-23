import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabNews'),
        centerTitle: true,
      ),
      body: BlocBuilder<TabnewsCubit, TabnewsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state == TabNewsLoading()) {
            return const Center(child: CircularProgressIndicator());
          } else if (state == TabNewsError()) {
            return const Center(child: Text('INTERNAL ERROR'));
          } else if (state == TabNewsSuccessful()) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.tabsList.length,
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
                                  '${index + 1}. ${cubit.tabsList[index].title}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      '${cubit.tabsList[index].tabcoins} tabcoins | ',
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${cubit.tabsList[index].childrenDeepCount} comentários | ',
                                    ),
                                    TextSpan(
                                      text: cubit.tabsList[index].ownerUsername,
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

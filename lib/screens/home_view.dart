import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/resources/color_manager.dart';
import 'package:todo_app/resources/routes_manager.dart';
import 'package:todo_app/resources/strings_manager.dart';
import 'package:todo_app/resources/values_manager.dart';
import 'package:todo_app/screens/all_screen.dart';
import 'package:todo_app/screens/complete_screen.dart';
import 'package:todo_app/screens/favorite_screen.dart';
import 'package:todo_app/screens/un_complete_screen.dart';

import '../cubit/task/task_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);

        return DefaultTabController(
          initialIndex: 0,
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: AppSize.s120,
              actions: [
                IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.settingsRoute);
                  },
                  icon: Icon(Icons.settings),
                ),
                const SizedBox(
                  width: AppMargin.m20,
                ),
                IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.scheduleRoute);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                ),
                const SizedBox(
                  width: AppMargin.m20,
                )
              ],
              title: const Text(
                AppStrings.board,
              ),
              bottom: TabBar(
                physics: const BouncingScrollPhysics(),
                isScrollable: true,
                //indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Text(
                      AppStrings.all,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Tab(
                    child: Text(AppStrings.completed,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  Tab(
                    child: Text(
                      AppStrings.un_completed,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Tab(
                    child: Text(
                      AppStrings.favorite,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      AllScreen(cubit: cubit),
                      CompleteScreen(cubit: cubit),
                      UnCompleteScreen(cubit: cubit),
                      FavoriteScreen(cubit: cubit),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        cubit.colors[AppSize.s10.toInt()],
                        cubit.colors[AppSize.s10.toInt() + AppSize.s10.toInt()],
                        cubit.colors[AppSize.s10.toInt() +
                            AppSize.s10.toInt() +
                            AppSize.s10.toInt()],

                        //add more colors
                      ]),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                    ),
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () async {
                        Navigator.pushNamed(context, Routes.addTaskRoute);
                      },
                      child: Text(
                        AppStrings.add_task,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

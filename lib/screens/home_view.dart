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
import '../shared/network/sql_helper.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
                    Navigator.pushNamed(context, Routes.scheduleRoute);
                  },
                  icon: Icon(
                    color: ColorManger.black,
                    size: AppSize.s30,
                    Icons.calendar_today,
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
              title: Text(
                AppStrings.board,
              ),
              bottom: TabBar(
                physics: BouncingScrollPhysics(),
                isScrollable: true,
                indicatorColor: ColorManger.black,
                //indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Text(
                      'All',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Completed',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Uncompleted',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favorite',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      AllScreen(cubit: cubit),
                      CompleteScreen(cubit: cubit),
                      UnCompleteScreen(cubit: cubit),
                      FavoriteScreen(cubit: cubit),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, Routes.addTaskRoute);
                      },
                      child: Text(
                        'Add a Task',
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

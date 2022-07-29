import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/task/task_cubit.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: AppSize.s20,
                color: ColorManger.black,
                Icons.arrow_back_ios_new,
              ),
            ),
            toolbarHeight: AppSize.s120,
            title: const Text(AppStrings.settings),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    AppStrings.theme_mode,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.center,
                    child: LayoutBuilder(
                        builder: (context, constraints) => ToggleButtons(
                              constraints: BoxConstraints.expand(
                                  width: (constraints.maxWidth / 2) - 10),
                              isSelected: [
                                cubit.darkModeSelected,
                                !cubit.darkModeSelected,
                              ],
                              onPressed: (index) {
                                index == 0
                                    ? cubit.changeAppMode(fromShared: true)
                                    : cubit.changeAppMode(fromShared: false);
                                index == 0 ? print('dark') : print('light');
                              },
                              children: [
                                Text(
                                  'Dark',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                Text(
                                  'Light',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

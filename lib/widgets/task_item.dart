import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../cubit/task/task_cubit.dart';
import '../models/task_model.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.cubit,
    required this.items,
  }) : super(key: key);

  final TaskCubit cubit;
  final List<TaskModel> items;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8,
        top: AppPadding.p18,
      ),
      child: Column(
        children: [
          Expanded(
            child: ConditionalBuilder(
              condition: items.isNotEmpty,
              fallback: (context) => Center(
                child: Text(
                  'No Tasks Here',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              builder: (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showMenu(
                        elevation: 0,
                        context: context,
                        position: new RelativeRect.fromLTRB(
                            mediaQuery.size.width / 2 - 140,
                            mediaQuery.size.height / 2,
                            mediaQuery.size.width / 2 + 140,
                            mediaQuery.size.height / 2),
                        items: [
                          PopupMenuItem(
                            onTap: () {
                              cubit.deleteTask(items[index]).then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor: cubit.colors[index],
                                        content: Text(
                                            textAlign: TextAlign.center,
                                            AppStrings.remove_task_forever,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ),
                                    ),
                                  );
                            },
                            padding: EdgeInsets.all(AppPadding.p0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: AppSize.s30,
                                  color: ColorManger.errorLight,
                                ),
                                SizedBox(
                                  width: AppSize.s4,
                                ),
                                Text(
                                  'Remove From Tasks',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    onDoubleTap: () =>
                        cubit.toggleIsFavorite(items[index]).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: cubit.colors[index],
                                  content: Text(
                                      textAlign: TextAlign.center,
                                      items[index].isFavorite
                                          ? AppStrings.add_task_favorite
                                          : AppStrings.remove_task_favorite,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                    onTap: () =>
                        cubit.toggleIsChecked(items[index], context).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: cubit.colors[index],
                                  content: Text(
                                      textAlign: TextAlign.center,
                                      items[index].isCompleted
                                          ? AppStrings.check_task
                                          : AppStrings.un_check_task,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                ),
                              ),
                            ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppPadding.p8),
                      child: Row(
                        children: [
                          items[index].isCompleted
                              ? Container(
                                  width: AppSize.s30,
                                  height: AppSize.s30,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        cubit.colors[index],
                                        cubit.colors.last,
                                      ]),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8)),
                                  child: Icon(
                                    Icons.check,
                                    color: ColorManger.white,
                                  ),
                                )
                              : Container(
                                  width: AppSize.s30,
                                  height: AppSize.s30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: AppSize.s4,
                                        color: cubit.colors[index],
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8)),
                                ),
                          SizedBox(
                            width: AppMargin.m12,
                          ),
                          FittedBox(
                            child: Text(
                              items[index].title!,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

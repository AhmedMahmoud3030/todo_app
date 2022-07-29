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
                  AppStrings.no_task_here,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              builder: (context) => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showMenu(
                        elevation: AppSize.s0,
                        context: context,
                        position: RelativeRect.fromLTRB(
                            mediaQuery.size.width / AppSize.s2 - AppSize.s140,
                            mediaQuery.size.height / AppSize.s2,
                            mediaQuery.size.width / AppSize.s2 + AppSize.s140,
                            mediaQuery.size.height / AppSize.s2),
                        items: [
                          PopupMenuItem(
                            onTap: () {
                              cubit.deleteTask(items[index]).then(
                                    (value) => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        content: Text(
                                            textAlign: TextAlign.center,
                                            AppStrings.removed_from_tasks,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                      ),
                                    ),
                                  );
                            },
                            padding: const EdgeInsets.all(AppPadding.p0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Theme.of(context).iconTheme.color,
                                  size: Theme.of(context).iconTheme.size,
                                ),
                                SizedBox(
                                  width: AppMargin.m8,
                                ),
                                Text(
                                  AppStrings.remove_from_tasks,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                      textAlign: TextAlign.center,
                                      items[index].isFavorite
                                          ? AppStrings.added_to_favorite
                                          : AppStrings.removed_from_favorite,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                ),
                              ),
                            ),
                    onTap: () =>
                        cubit.toggleIsChecked(items[index], context).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                      textAlign: TextAlign.center,
                                      items[index].isCompleted
                                          ? AppStrings.checked_this_task
                                          : AppStrings.un_checked_this_task,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
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
                                    color: Theme.of(context).iconTheme.color,
                                    size: Theme.of(context).iconTheme.size,
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
                          const SizedBox(
                            width: AppMargin.m12,
                          ),
                          FittedBox(
                            child: Text(
                              items[index].title!,
                              style: Theme.of(context).textTheme.headlineSmall,
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

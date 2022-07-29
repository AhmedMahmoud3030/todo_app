import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/task/task_cubit.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        cubit.generateDays();

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: Theme.of(context).iconTheme.size,
                color: Theme.of(context).iconTheme.color,
                Icons.arrow_back_ios_new,
              ),
            ),
            toolbarHeight: AppSize.s120,
            title: const Text(AppStrings.schedule),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.s100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.days.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      child: Container(
                        width: MediaQuery.of(context).size.width / AppSize.s8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: cubit.days[index] == cubit.selectedDay
                                ? Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor!
                                : Theme.of(context).backgroundColor,
                          ),
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          gradient:
                              DateFormat.yMd().format(cubit.days[index]) ==
                                      DateFormat.yMd().format(cubit.now)
                                  ? LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: const [
                                        0.1,
                                        0.4,
                                        0.6,
                                        0.9,
                                      ],
                                      colors: [
                                        cubit.colors[index],
                                        cubit.colors[index + 1],
                                        cubit.colors[index + 2],
                                        cubit.colors[index + 3],
                                      ],
                                    )
                                  : LinearGradient(
                                      colors: [
                                        Theme.of(context).backgroundColor,
                                        Theme.of(context).backgroundColor,
                                      ],
                                    ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            cubit.getTasksByDay(index: index);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat.E()
                                    .format(
                                      cubit.firstDayOfWeek.add(
                                        Duration(days: index),
                                      ),
                                    )
                                    .toString(),
                                style: DateFormat.yMd()
                                            .format(cubit.days[index]) ==
                                        DateFormat.yMd().format(cubit.now)
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                DateFormat.d()
                                    .format(cubit.firstDayOfWeek
                                        .add(Duration(days: index)))
                                    .toString(),
                                style: DateFormat.yMd()
                                            .format(cubit.days[index]) ==
                                        DateFormat.yMd().format(cubit.now)
                                    ? Theme.of(context).textTheme.displaySmall
                                    : Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.EEEE().format(cubit.selectedDay),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        DateFormat.yMMMd().format(cubit.selectedDay),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.tasksByDays.isNotEmpty,
                    fallback: (BuildContext context) => Center(
                      child: Text(
                        AppStrings.no_task_here,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    builder: (BuildContext context) => ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.tasksByDays.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: GestureDetector(
                          onTap: () => cubit
                              .toggleIsChecked(
                                  cubit.tasksByDays[index], context)
                              .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(
                                        textAlign: TextAlign.center,
                                        cubit.tasksByDays[index].isCompleted
                                            ? AppStrings.checked_this_task
                                            : AppStrings.un_checked_this_task,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium),
                                  ),
                                ),
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  stops: const [
                                    0.1,
                                    0.4,
                                    0.6,
                                    0.9,
                                  ],
                                  colors: [
                                    cubit.colors[index],
                                    cubit.colors[index + 1],
                                    cubit.colors[index + 2],
                                    cubit.colors[index + 3],
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12)),
                            height: AppSize.s80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        cubit.tasksByDays[index].startTime!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                      Text(
                                        cubit.tasksByDays[index].title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                  cubit.tasksByDays[index].isCompleted
                                      ? Icon(
                                          size: AppSize.s30,
                                          Icons.check_circle,
                                          color: ColorManger.white,
                                        )
                                      : Icon(
                                          size: AppSize.s30,
                                          Icons.circle_outlined,
                                          color: ColorManger.white,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
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

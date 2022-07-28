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
        cubit.getFirstDayOfWeek();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: 20,
                color: ColorManger.black,
                Icons.arrow_back_ios_new,
              ),
            ),
            toolbarHeight: AppSize.s120,
            title: Text(AppStrings.schedule),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            color:
                                cubit.firstDayOfWeek.isAfter(DateTime.now()) ||
                                        cubit.firstDayOfWeek
                                            .isAtSameMomentAs(DateTime.now())
                                    ? ColorManger.lightGrey
                                    : ColorManger.grey2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat.E()
                                  .format(cubit.firstDayOfWeek
                                      .add(Duration(days: index)))
                                  .toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              DateFormat.d()
                                  .format(cubit.firstDayOfWeek
                                      .add(Duration(days: index)))
                                  .toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
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

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_item.dart';

import '../cubit/task/task_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class UnCompleteScreen extends StatelessWidget {
  final TaskCubit cubit;

  const UnCompleteScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items =
        cubit.tasks.where((element) => element.isCompleted == false).toList();
    return TaskItem(cubit: cubit, items: items);
  }
}

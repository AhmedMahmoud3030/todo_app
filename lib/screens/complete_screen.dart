import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

import '../cubit/task/task_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/task_item.dart';

class CompleteScreen extends StatelessWidget {
  final TaskCubit cubit;

  const CompleteScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items =
        cubit.tasks.where((element) => element.isCompleted == true).toList();
    return TaskItem(cubit: cubit, items: items);
  }
}

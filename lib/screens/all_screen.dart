import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/resources/strings_manager.dart';
import 'package:todo_app/widgets/task_item.dart';

import '../cubit/task/task_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class AllScreen extends StatelessWidget {
  final TaskCubit cubit;
  const AllScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = cubit.tasks;

    return TaskItem(cubit: cubit, items: items);
  }
}

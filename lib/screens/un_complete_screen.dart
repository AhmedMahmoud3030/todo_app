import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_item.dart';

import '../cubit/task/task_cubit.dart';

class UnCompleteScreen extends StatelessWidget {
  final TaskCubit cubit;

  const UnCompleteScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items =
        cubit.tasks.where((element) => element.isCompleted == false).toList();

    return TaskItem(
      cubit: cubit,
      items: items,
    );
  }
}

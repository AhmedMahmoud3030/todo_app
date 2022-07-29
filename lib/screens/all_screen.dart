import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_item.dart';

import '../cubit/task/task_cubit.dart';

class AllScreen extends StatelessWidget {
  final TaskCubit cubit;
  const AllScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = cubit.tasks;

    return TaskItem(
      cubit: cubit,
      items: items,
    );
  }
}

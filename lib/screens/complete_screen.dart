import 'package:flutter/material.dart';

import '../cubit/task/task_cubit.dart';
import '../widgets/task_item.dart';

class CompleteScreen extends StatelessWidget {
  final TaskCubit cubit;

  const CompleteScreen({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items =
        cubit.tasks.where((element) => element.isCompleted == true).toList();
    return TaskItem(
      cubit: cubit,
      items: items,
    );
  }
}

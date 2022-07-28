part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitialState extends TaskState {}

//?create task
class CreateTaskLoadingState extends TaskState {}

class CreateTaskSuccessState extends TaskState {}

class CreateTaskErrorState extends TaskState {
  final message;
  CreateTaskErrorState(this.message);
}

//?get task
class GetTasksLoadingState extends TaskState {}

class GetTasksSuccessState extends TaskState {}

class GetTaskErrorState extends TaskState {
  final message;
  GetTaskErrorState(this.message);
}

//?delete task
class DeleteTasksLoadingState extends TaskState {}

class DeleteTasksSuccessState extends TaskState {}

class DeleteTaskErrorState extends TaskState {
  final message;
  DeleteTaskErrorState(this.message);
}

//?isCheckState
class IsCheckRefreshState extends TaskState {}

//?isFavoriteState
class IsFavoriteRefreshState extends TaskState {}

//?changeDateView
class ChangeDateRefreshState extends TaskState {}

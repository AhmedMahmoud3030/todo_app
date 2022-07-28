import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/network/sql_helper.dart';
import 'package:todo_app/utils/unique_id.dart';

import '../../resources/color_manager.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of(context);

  var ids = UniqueIds();
  final title = TextEditingController();
  final date = TextEditingController();
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  var remind = 'remind_2';
  var repeat = 'repeat_2';
  DateTime firstDayOfWeek = DateTime(2022);
  void getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    firstDayOfWeek = now.subtract(Duration(days: currentDay));
  }

  List<TaskModel> tasks = [];
  List<Color> colors = [];

  void addData() async {
    emit(CreateTaskLoadingState());

    await SQLHelper.createTask(
      TaskModel(
        id: ids.getCustomUniqueId(),
        title: title.text,
        date: date.text,
        startTime: startTime.text,
        endTime: endTime.text,
        remind: remind,
        repeat: repeat,
      ),
    ).then((vale) {
      print('value ${vale}');
      emit(CreateTaskSuccessState());
    }).catchError((err) {
      emit(CreateTaskErrorState(err));
    });
  }

  void getTasks() async {
    emit(GetTasksLoadingState());
    tasks = [];
    var data = await SQLHelper.getTasks();
    for (var i = 0; i < data.length; i++) {
      tasks.insert(
        i,
        TaskModel(
          id: data[i]['id'],
          title: data[i]['title'],
          date: data[i]['date'],
          startTime: data[i]['starttime'],
          endTime: data[i]['endtime'],
          remind: data[i]['remind'],
          repeat: data[i]['repeat'],
          isFavorite: data[i]['isFavorite'] == 'true' ? true : false,
          isCompleted: data[i]['isCompleted'] == 'true' ? true : false,
        ),
      );
    }

    if (tasks.isNotEmpty) {
      emit(GetTasksSuccessState());
    } else {
      emit(GetTaskErrorState('message'));
    }
  }

  Future<void> deleteTask(TaskModel model) async {
    emit(DeleteTasksLoadingState());
    tasks.removeWhere((element) => element.id == model.id);
    await SQLHelper.deleteTask(model.id!)
        .then((value) => emit(DeleteTasksSuccessState()))
        .catchError((err) {
      print(err);
      emit(DeleteTaskErrorState(err));
    });
    //getTasks();
  }

  Future<void> toggleIsChecked(TaskModel model, BuildContext context) async {
    model.isCompleted = !model.isCompleted;
    await SQLHelper.updateTask(model).then((value) => print(value.toString()));
    //getTasks();
    emit(IsCheckRefreshState());
  }

  Future<void> toggleIsFavorite(TaskModel model) async {
    model.isFavorite = !model.isFavorite;
    await SQLHelper.updateTask(model).then((value) => print(value.toString()));
    emit(IsFavoriteRefreshState());
  }

  List<Color> getRandColor() {
    colors = [];
    for (var i = 0; i < tasks.length; i++) {
      colors.insert(i, (ColorManger.taskColors..shuffle()).first);
    }
    return colors;
  }

  // void getCompletedTasks() {
  //   emit(GetTasksCompleteState());
  // }
  //
  // void getUnCompletedTasks() {
  //   print(unCompletedTasks);
  //   emit(GetTasksUnCompleteState());
  // }
  //
  // void getFavoriteTasks() {
  //   print(favoriteTasks);
  //   emit(GetTasksFavoriteState());
  // }
}

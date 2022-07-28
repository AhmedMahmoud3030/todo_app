import 'dart:math';

import 'package:add_2_calendar/add_2_calendar.dart' as ato;
import 'package:alarm_calendar/alarm_calendar_plugin.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/network/sql_helper.dart';
import 'package:todo_app/utils/unique_id.dart';

import '../../models/eventModel.dart';
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
  Calendar calendar = Calendar();
  var remind = 'remind_2';
  var repeat = 'repeat_2';
  DateTime firstDayOfWeek = DateTime(2022);
  DateTime selectedDay = DateTime(2022);
  DateTime now = DateTime.now();
  List<DateTime> days = [];
  List<TaskModel> tasks = [];
  List<TaskModel> tasksByDays = [];
  DeviceCalendarPlugin deviceCalendarPlugin = DeviceCalendarPlugin();

  List<Color> colors = [];

  void generateDays() async {
    int currentDay = now.weekday;
    firstDayOfWeek = now.subtract(Duration(days: currentDay));

    days = [];
    for (var i = 0; i < 7; i++) {
      days.insert(i, firstDayOfWeek.add(Duration(days: i, seconds: i)));
    }

    print('firstDayOfWeek${firstDayOfWeek}');
    print('selectedDay${selectedDay}');
    print('now${now}');
  }

  void getTasksByDay({int index = 0}) {
    selectedDay = days[index];
    tasksByDays = [];
    tasksByDays = tasks
        .where(
            (element) => element.date == DateFormat.yMd().format(days[index]))
        .toList();
    emit(ChangeDateRefreshState());
  }

  Future<tz.TZDateTime> getTZDateFromString(String date) async {
    var locString = await FlutterNativeTimezone.getLocalTimezone();
    var dateTime = DateFormat.yMd().parse(date).toLocal();
    tz.Location location = tz.getLocation(locString);
    tz.setLocalLocation(location);
    var time = tz.TZDateTime.parse(location, dateTime.toString());
    return time;
  }

  Future<tz.TZDateTime> getTZTimeFromString(String date) async {
    var locString = await FlutterNativeTimezone.getLocalTimezone();
    var dateTime = DateFormat.yMd().parse(date).toLocal();
    dateTime.add(Duration(days: 3));
    tz.Location location = tz.getLocation(locString);
    tz.setLocalLocation(location);
    var time = tz.TZDateTime.parse(location, dateTime.toString());
    return time;
  }

  Future<List<Calendar>> loadCalendars() async {
    //Added for visual purposes
    await Future.delayed(const Duration(seconds: 1));
    // Retrieve user's calendars from mobile device
    // Request permissions first if they haven't been granted
    var _calendars;
    try {
      var arePermissionsGranted = await deviceCalendarPlugin.hasPermissions();
      if (arePermissionsGranted.isSuccess && !arePermissionsGranted.data!) {
        arePermissionsGranted = await deviceCalendarPlugin.requestPermissions();
        if (!arePermissionsGranted.isSuccess || !arePermissionsGranted.data!) {
          return List.empty();
        }
      }
      final calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
      _calendars = calendarsResult.data;
      if (_calendars.isEmpty) {
        return List.empty();
      }
    } catch (e) {
      print(e.toString());
    }
    return _calendars;
  }

  Future<void> addToCalendar(
      CalendarEventModel calendarEventModel, String selectedCalendarId) async {
    emit(AddToCalendarInProgress());
    //Added for visual purposes
    await Future.delayed(const Duration(seconds: 2));

    final eventTime = DateTime.now();
    final eventToCreate = Event(
      selectedCalendarId,
      title: calendarEventModel.eventTitle,
      description: calendarEventModel.eventDescription,
      start: await getTZTimeFromString(DateTime.now().toString()),
      end: await getTZDateFromString(DateTime.now().toString()),
    );

    final createEventResult =
        await deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);

    if (createEventResult!.isSuccess &&
        (createEventResult.data?.isNotEmpty ?? false)) {}
  }

  TimeOfDay getTimeFromString(String date) {
    var timeOfDay = TimeOfDay.fromDateTime(DateFormat.jm().parse(date));
    return timeOfDay;
  }

  DateTime getDateFromTimeString(String date) {
    var timeOfDay = TimeOfDay.fromDateTime(DateFormat.jm().parse(date));
    final now = new DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  addData() async {
    emit(CreateTaskLoadingState());

    TaskModel model = TaskModel(
      id: ids.getCustomUniqueId(),
      title: title.text,
      date: date.text,
      startTime: startTime.text,
      endTime: endTime.text,
      remind: remind,
      repeat: repeat,
    );
    // calendar.name = 'todo';
    // calendar.id = model.id;
    // deviceCalendarPlugin.createCalendar(calendar.name,
    //     localAccountName: 'ahmed');
    // Event event = Event(calendar.id,
    //     start: await getTZDateFromString(model.date!),
    //     end: await getTZTimeFromString(model.date!));
    // //event.eventId = model.id;

    // event.title = model.date;
    // event.allDay = false;
    // event.description = model.title;
    // var permissionGranted = await deviceCalendarPlugin.requestPermissions();
    // if (!permissionGranted.isSuccess) {
    //   permissionGranted = await deviceCalendarPlugin.requestPermissions();
    // }

    // var result = await deviceCalendarPlugin.createOrUpdateEvent(event);
    // if (result!.isSuccess) {
    //   print('success adding event');
    // }
    // if (result.hasErrors) {
    //   print(result.errors[0].errorMessage);
    // }
    var loc = await FlutterNativeTimezone.getLocalTimezone();
    addEvent(
      repeat,
      remind,
      model.title.toString(),
      model.date.toString(),
      loc,
      getDateFromTimeString(model.startTime!),
      getDateFromTimeString(model.startTime!),
    );
    await SQLHelper.createTask(model).then((vale) async {
      emit(CreateTaskSuccessState());
    }).catchError((err) {
      emit(CreateTaskErrorState(err));
    });
  }

  void addEvent(
    String repeat,
    String remind,
    String title,
    String desc,
    String loc,
    DateTime start,
    DateTime end,
  ) async {
    var reminded = remind == 'remind_1'
        ? 10
        : remind == 'remind_2'
            ? 30
            : remind == 'remind_3'
                ? 60
                : 1440;
    final ato.Event event = ato.Event(
      timeZone: loc,
      recurrence: ato.Recurrence(
        frequency: repeat == 'repeat_1'
            ? ato.Frequency.daily
            : repeat == 'repeat_2'
                ? ato.Frequency.weekly
                : ato.Frequency.monthly,
      ),
      iosParams: ato.IOSParams(reminder: Duration(minutes: reminded)),
      androidParams: ato.AndroidParams(),
      title: title,
      description: desc,
      location: loc,
      startDate: start.subtract(Duration(minutes: reminded)),
      endDate: end,
    );
    await ato.Add2Calendar.addEvent2Cal(event);
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

  void getRandColor() {
    for (var i = 0; i < 100; i++) {
      colors.insert(i, (ColorManger.taskColors..shuffle()).first);
    }
    emit(IsFavoriteRefreshState());
  }
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


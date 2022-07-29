// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task.dart';
import 'package:todo_app/screens/home_view.dart';
import 'package:todo_app/screens/schedule_view.dart';
import 'package:todo_app/screens/settings.dart';

import 'strings_manager.dart';

class Routes {
  static const String homeRoute = '/';
  static const String addTaskRoute = '/add-task';
  static const String scheduleRoute = '/schedule';
  static const String settingsRoute = '/settings';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.addTaskRoute:
        return MaterialPageRoute(builder: (_) => AddTask());
      case Routes.scheduleRoute:
        return MaterialPageRoute(builder: (_) => ScheduleView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => Settings());

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  AppStrings.noRouteFound,
                ),
              ),
              body: Center(
                child: Text(
                  AppStrings.noRouteFound,
                ),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/task/task_cubit.dart';
import 'resources/routes_manager.dart';
import 'resources/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskCubit()..getTasks(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeRoute,
        theme: getApplicationTheme(),
        darkTheme: getApplicationTheme(),
      ),
    );
  }
}



// /* 
//  * @Author: 21克的爱情
//  * @Date: 2020-04-28 16:50:26
//  * @Email: raohong07@163.com
//  * @LastEditors: 21克的爱情
//  * @LastEditTime: 2021-02-04 19:46:06
//  * @Description: 
//  */

// import 'package:alarm_calendar/alarm_calendar_plugin.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Calendars calendars = new Calendars(
//       new DateTime.now(),
//       new DateTime.now().add(new Duration(hours: 1)),
//       '测试通知',
//       '测试通知描述',
//       [5],
//       '1',
//       1);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               MaterialButton(
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 child: new Text('create event'),
//                 onPressed: () {
//                   createEvent(calendars);
//                 },
//               ),
//               MaterialButton(
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 child: new Text('selectEvent'),
//                 onPressed: () {
//                   selectEvent(calendars.getEventId);
//                 },
//               ),
//               MaterialButton(
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 child: new Text('updateEvent'),
//                 onPressed: () async {
//                   calendarsInit();
//                   final id = await AlarmCalendar.updateEvent(calendars);
//                   print("updateEvent$id");
//                   calendars.setEventId = id!;
//                 },
//               ),
//               MaterialButton(
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 child: new Text('deleteEvent'),
//                 onPressed: () async {
//                   final status =
//                       await AlarmCalendar.deleteEvent(calendars.getEventId);
//                   print("deleteEvent$status");
//                   calendars.setEventId = '';
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void calendarsInit() {
//     //更新参数
//     calendars.setTitle = 'title';
//     calendars.setAlert = [3, 15];
//     calendars.setStartTime = new DateTime.now();
//     calendars.setEndTime = new DateTime.now().add(new Duration(days: 2));
//     calendars.setAllDay = 0;
//     calendars.setNote = 'note';
//   }

//   Future<void> createEvent(Calendars calendars) async {
//     //查询是否有读权限。
//     await AlarmCalendar.CheckReadPermission().then((res) async {
//       if (res != null) {
//         //查询是否有写权限
//         await AlarmCalendar.CheckWritePermission().then((resWrite) async {
//           if (resWrite != null) {
//             final id = await AlarmCalendar.createEvent(calendars);
//             calendars.setEventId = id!;
//             print('done' + id);
//           }
//         });
//       }
//     });
//   }

//   Future<void> selectEvent(String id) async {
//     //查询是否有读权限。
//     await AlarmCalendar.CheckReadPermission().then((res) async {
//       if (res != null) {
//         //查询是否有写权限
//         await AlarmCalendar.CheckWritePermission().then((resWrite) async {
//           if (resWrite != null) {
//             final result = await AlarmCalendar.selectEvent(id);
//             print('获取返回数据：$result');
//           }
//         });
//       }
//     });
//   }
// }


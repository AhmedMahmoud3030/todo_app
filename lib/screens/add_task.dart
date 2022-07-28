import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/resources/color_manager.dart';
import 'package:todo_app/resources/strings_manager.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

import '../cubit/task/task_cubit.dart';
import '../resources/values_manager.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        FocusNode focusNode = FocusNode();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                size: AppSize.s20,
                color: ColorManger.black,
                Icons.arrow_back_ios_new,
              ),
            ),
            toolbarHeight: AppSize.s120,
            title: Text(AppStrings.add_task),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppPadding.p16),
                    CustomTextFormField(
                      textEditingController: cubit.title,
                      textInputType: TextInputType.text,
                      hint: AppStrings.add_new_feature,
                      validator: (String? s) {
                        if (s!.isEmpty) return "Can'\t be empty";
                        return null;
                      },
                      onSaved: (String? s) {
                        cubit.title.text = s!;
                      },
                      //onPressed: () {},
                    ),
                    SizedBox(height: AppPadding.p32),
                    Text(
                      AppStrings.date,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppPadding.p16),
                    CustomTextFormField(
                      textEditingController: cubit.date,
                      onSaved: (s) {},
                      validator: (String? s) {
                        if (s!.isEmpty) return "Can'\t be empty";
                        return null;
                      },
                      hint: '7/23/2022',
                      icon: Icons.keyboard_arrow_down_sharp,
                      onPressed: () {
                        focusNode.unfocus();
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          //print(value);

                          return cubit.date.text =
                              DateFormat.yMd().format(value!);
                        });
                      },
                    ),
                    SizedBox(height: AppPadding.p32),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Start time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              SizedBox(height: AppPadding.p16),
                              GestureDetector(
                                onTap: () {
                                  focusNode.unfocus();
                                },
                                child: CustomTextFormField(
                                  onSaved: (s) {},
                                  validator: (String? s) {
                                    if (s!.isEmpty) return "Can'\t be empty";
                                    return null;
                                  },
                                  textInputType: TextInputType.datetime,
                                  textEditingController: cubit.startTime,
                                  hint: '11:00 AM',
                                  icon: Icons.timelapse,
                                  onPressed: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      return cubit.startTime.text =
                                          value!.format(context);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppPadding.p16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('End time',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              SizedBox(height: AppPadding.p16),
                              CustomTextFormField(
                                hint: '12:00 PM',
                                icon: Icons.timelapse,
                                onPressed: () {
                                  focusNode.unfocus();
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: TimeOfDay.now().hour + 1,
                                      minute: TimeOfDay.now().minute,
                                    ),
                                  ).then((value) {
                                    return cubit.endTime.text =
                                        value!.format(context);
                                  });
                                },
                                onSaved: (String? s) {},
                                validator: (String? s) {
                                  if (s!.isEmpty) return "Can'\t be empty";
                                  return null;
                                },
                                textEditingController: cubit.endTime,
                                textInputType: TextInputType.datetime,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: AppPadding.p32),
                    Text('Remind',
                        style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: AppPadding.p16),
                    DropdownButtonFormField<dynamic>(
                      validator: (s) {
                        if (s!.isEmpty) return "Can'\t be empty";
                        return null;
                      },
                      onSaved: (newValue) {
                        print(newValue);
                      },
                      value: 'remind_2',
                      // hint: Text('choose the time you want us to remind you'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                            child: Text(
                              '10 minute before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "remind_1"),
                        DropdownMenuItem(
                            child: Text(
                              '30 minute before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "remind_2"),
                        DropdownMenuItem(
                            child: Text(
                              '1 hour before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "remind_3"),
                        DropdownMenuItem(
                            child: Text(
                              '1 day before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "remind_4"),
                      ],
                      onChanged: (value) {
                        cubit.remind = value;
                      },
                    ),
                    SizedBox(height: AppPadding.p32),
                    Text(
                      'Repeat',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppPadding.p16),
                    DropdownButtonFormField<dynamic>(
                      validator: (s) {
                        if (s!.isEmpty) return "Can'\t be empty";
                        return null;
                      },
                      onSaved: (newValue) {},
                      value: 'repeat_2',
                      //hint: Text('choose the schedule  you want to repeat this'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                            child: Text(
                              'daily',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "repeat_1"),
                        DropdownMenuItem(
                            child: Text(
                              'weekly',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "repeat_2"),
                        DropdownMenuItem(
                            child: Text(
                              'monthly',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            value: "repeat_3"),
                      ],
                      onChanged: (value) {
                        cubit.repeat = value;
                      },
                    ),
                    SizedBox(
                      height: AppSize.s18,
                    ),
                    Container(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                cubit.colors[Random().nextInt(100)],
                                cubit.colors[Random().nextInt(100)],
                                cubit.colors[Random().nextInt(100)],

                                //add more colors
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ],
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => Colors.transparent),
                                surfaceTintColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => Colors.transparent),
                                shadowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => Colors.transparent),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => Colors.transparent),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (states) => 0),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                        (states) => Colors.transparent),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  cubit.addData();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: ColorManger.lightBlack,
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'Processing Data',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context);
                                  cubit.getTasks();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: ColorManger.lightBlack,
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'Please Fill Task Details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Create a Task',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

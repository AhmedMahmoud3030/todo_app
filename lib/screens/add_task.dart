import 'dart:math';

import 'package:flutter/foundation.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                color: Theme.of(context).iconTheme.color,
                size: Theme.of(context).iconTheme.size,
                Icons.arrow_back_ios_new,
              ),
            ),
            toolbarHeight: AppSize.s120,
            title: const Text(AppStrings.add_task),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                    const SizedBox(height: AppMargin.m16),
                    CustomTextFormField(
                      textEditingController: cubit.title,
                      textInputType: TextInputType.text,
                      hint: AppStrings.add_new_feature,
                      validator: (String? s) {
                        if (s!.isEmpty) return AppStrings.vald_error;
                        return null;
                      },
                      onSaved: (String? s) {
                        cubit.title.text = s!;
                      },
                      //onPressed: () {},
                    ),
                    const SizedBox(height: AppMargin.m32),
                    Text(
                      AppStrings.date,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppMargin.m16),
                    CustomTextFormField(
                      textEditingController: cubit.date,
                      onSaved: (s) {},
                      validator: (String? s) {
                        if (s!.isEmpty) return AppStrings.vald_error;
                        return null;
                      },
                      hint: AppStrings.hint_date,
                      icon: Icons.keyboard_arrow_down_sharp,
                      onPressed: () {
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
                    const SizedBox(height: AppMargin.m32),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.add_new_feature,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: AppMargin.m16),
                              GestureDetector(
                                onTap: () {},
                                child: CustomTextFormField(
                                  onSaved: (s) {},
                                  validator: (String? s) {
                                    if (s!.isEmpty)
                                      return AppStrings.vald_error;
                                    return null;
                                  },
                                  textInputType: TextInputType.datetime,
                                  textEditingController: cubit.startTime,
                                  hint: AppStrings.add_new_feature,
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
                        const SizedBox(width: AppMargin.m16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.end_time,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: AppMargin.m16),
                              CustomTextFormField(
                                hint: AppStrings.hint_time,
                                icon: Icons.timelapse,
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    cancelText:
                                        AppStrings.show_time_picker_cancel,
                                    confirmText:
                                        AppStrings.show_time_picker_confirm,
                                    helpText: 'hehe',
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
                                  if (s!.isEmpty) return AppStrings.vald_error;
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
                    const SizedBox(height: AppPadding.p32),
                    Text('Remind',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppPadding.p16),
                    DropdownButtonFormField<dynamic>(
                      validator: (s) {
                        if (s!.isEmpty) return "Can'\t be empty";
                        return null;
                      },
                      onSaved: (newValue) {
                        if (kDebugMode) {
                          print(newValue);
                        }
                      },
                      value: 'remind_2',
                      // hint: Text('choose the time you want us to remind you'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                            value: "remind_1",
                            child: Text(
                              '10 minute before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DropdownMenuItem(
                            value: "remind_2",
                            child: Text(
                              '30 minute before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DropdownMenuItem(
                            value: "remind_3",
                            child: Text(
                              '1 hour before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DropdownMenuItem(
                            value: "remind_4",
                            child: Text(
                              '1 day before',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ],
                      onChanged: (value) {
                        cubit.remind = value;
                      },
                    ),
                    const SizedBox(height: AppPadding.p32),
                    Text(
                      'Repeat',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppPadding.p16),
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
                            value: "repeat_1",
                            child: Text(
                              'daily',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DropdownMenuItem(
                            value: "repeat_2",
                            child: Text(
                              'weekly',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                        DropdownMenuItem(
                            value: "repeat_3",
                            child: Text(
                              'monthly',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                      ],
                      onChanged: (value) {
                        cubit.repeat = value;
                      },
                    ),
                    const SizedBox(
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
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color(0x00000000), //shadow for button
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
                                      duration: const Duration(seconds: 1),
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
                                      duration: const Duration(seconds: 1),
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

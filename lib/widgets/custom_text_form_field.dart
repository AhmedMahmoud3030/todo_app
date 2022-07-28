import 'package:flutter/material.dart';
import 'package:todo_app/resources/color_manager.dart';
import 'package:todo_app/resources/values_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final VoidCallback? onPressed;
  final Function(String? s) onSaved;
  final String? Function(String? s) validator;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;

  const CustomTextFormField({
    super.key,
    this.icon,
    required this.hint,
    this.onPressed,
    required this.onSaved,
    required this.validator,
    this.textInputType = TextInputType.name,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      //enabled: false,
      controller: textEditingController,
      onSaved: onSaved,
      validator: validator,
      keyboardType: textInputType,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(AppPadding.p6),
        hintText: hint,
        suffixIcon: icon != null
            ? IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  color: ColorManger.darkGrey,
                  icon,
                ),
                onPressed: onPressed,
              )
            : null,
      ),
    );
  }
}

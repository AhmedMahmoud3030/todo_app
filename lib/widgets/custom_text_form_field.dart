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
      style: Theme.of(context).textTheme.headlineSmall,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icon != null
            ? IconButton(
                icon: Icon(
                  color: Theme.of(context).iconTheme.color,
                  size: Theme.of(context).iconTheme.size,
                  icon,
                ),
                onPressed: onPressed,
              )
            : null,
      ),
    );
  }
}

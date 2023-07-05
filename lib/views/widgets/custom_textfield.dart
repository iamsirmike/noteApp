import 'package:flutter/material.dart';
import 'package:kngtakehome/views/home/widgets/input_decoration.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.filled = false,
    this.isRequired = true,
    this.readOnly = false,
    required this.hint,
    this.suffixIcon,
    this.maxLines,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.onValidate,
  });
  final TextEditingController? controller;
  final String hint;
  final bool filled;
  final bool readOnly;
  final bool isRequired;
  final Widget? suffixIcon;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final String? initialValue;
  final Function(String value)? onSaved;
  final Function(String value)? onChanged;
  final String? Function(String value)? onValidate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      initialValue: initialValue,
      readOnly: readOnly,
      onChanged: (value) {
        if (onChanged == null) return;
        onChanged!.call(value);
      },
      onSaved: (value) {
        if (value == null || onSaved == null) return;
        onSaved!(value);
      },
      validator: (value) {
        if (!isRequired && (value?.trim().isEmpty ?? true)) return null;

        String? errorMsg;

        if (value!.trim().isEmpty) errorMsg = 'This field is required';

        if (errorMsg == null && onValidate != null) {
          errorMsg = onValidate!(value);
        }

        return errorMsg;
      },
      style: textStyle,
      decoration: inputDecoration(
        hint: hint,
        suffixIcon: suffixIcon,
        filledColor: filled,
        textStyle: hintStyle,
      ),
    );
  }
}

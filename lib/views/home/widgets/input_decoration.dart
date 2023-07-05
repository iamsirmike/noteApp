import 'package:flutter/material.dart';
import 'package:kngtakehome/utils/colors.dart';

InputDecoration inputDecoration({
  required String hint,
  Widget? suffixIcon,
  bool filledColor = false,
  final TextStyle? textStyle,
}) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
    hintStyle: textStyle,
    fillColor: AppColors.navButtonColor,
    filled: filledColor,
    suffixIcon: suffixIcon,
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 1,
        color: Colors.transparent,
      ),
    ),
  );
}

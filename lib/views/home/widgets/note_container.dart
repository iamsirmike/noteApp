import 'package:flutter/material.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    super.key,
    required this.colorCode,
    required this.title,
  });
  final int colorCode;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: 365,
        constraints: const BoxConstraints(minHeight: 110),
        decoration: BoxDecoration(
          color: Color(colorCode),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

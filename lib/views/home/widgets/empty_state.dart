import 'package:flutter/material.dart';
import 'package:kngtakehome/utils/colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.imagePath,
    required this.description,
  });
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Image.asset(
              imagePath,
              width: 350,
              height: 286,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kngtakehome/utils/colors.dart';

class SwipeToDeleteBackground extends StatelessWidget {
  const SwipeToDeleteBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.delete,
          size: 40,
          color: AppColors.white,
        ),
      ),
    );
  }
}

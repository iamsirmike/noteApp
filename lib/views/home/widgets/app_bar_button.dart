
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color(0xFF3B3B3B),
            borderRadius: BorderRadius.circular(15)),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

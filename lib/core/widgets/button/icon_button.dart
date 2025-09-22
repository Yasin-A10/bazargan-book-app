import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon; // آیکون
  final Color iconColor; // رنگ آیکون
  final Color backgroundColor; // رنگ پس‌زمینه
  final double iconSize; // سایز آیکون
  final VoidCallback onPressed; // اکشن

  const CustomIconButton({
    super.key,
    required this.icon,
    this.iconColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.iconSize = 24,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}

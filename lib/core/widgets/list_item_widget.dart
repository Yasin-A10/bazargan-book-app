import 'package:bazargan/core/constants/colors.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String title;
  final Widget? rightIcon;
  final IconData? leftIcon;
  final TextStyle? titleStyle;
  final VoidCallback? onPressed;

  const ListItemWidget({
    super.key,
    required this.title,
    this.rightIcon,
    this.leftIcon,
    this.titleStyle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (rightIcon != null) rightIcon!,
            const SizedBox(width: 8),
            Text(title, style: titleStyle),
            const Spacer(),
            if (leftIcon != null)
              Icon(leftIcon, color: AppColors.neutral757575, size: 20),
          ],
        ),
      ),
    );
  }
}

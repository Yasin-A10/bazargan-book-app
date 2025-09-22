import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';

class InputTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final String label;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  const InputTextFormField({
    super.key,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.label,
    this.controller,
    this.minLines,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        obscureText: obscureText,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines ?? 1,
        validator: validator,
        style: const TextStyle(fontFamily: 'IRANYekanX'),
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          labelStyle: const TextStyle(
            color: AppColors.neutral757575,
            fontFamily: 'IRANYekanX',
          ),

          // رنگ لیبل در حالت فوکوس یا خطا به صورت پویا
          floatingLabelStyle: WidgetStateTextStyle.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.error)) {
              return const TextStyle(
                color: AppColors.error,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'IRANYekanX',
              );
            }
            if (states.contains(WidgetState.focused)) {
              return const TextStyle(
                color: AppColors.secondary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'IRANYekanX',
              );
            }
            return const TextStyle(
              color: AppColors.neutral757575,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'IRANYekanX',
            );
          }),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.neutralE3E3E3,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.secondary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
          errorStyle: const TextStyle(
            color: AppColors.error,
            fontFamily: 'IRANYekanX',
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

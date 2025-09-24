import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:bazargan/core/constants/colors.dart';

class CustomOtpField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onCompleted;
  final int length;

  const CustomOtpField({
    super.key,
    this.controller,
    this.onCompleted,
    this.length = 5,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 44,
      height: 44,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.neutralMidnight,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.neutralE3E3E3),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: widget.length,
        controller: widget.controller,
        focusNode: _focusNode,
        defaultPinTheme: defaultPinTheme,
        onCompleted: widget.onCompleted,

        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColors.secondary, width: 2),
          ),
        ),
        submittedPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            color: AppColors.neutralEDEDED,
            border: Border.all(color: AppColors.neutralE3E3E3),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: AppColors.error, width: 2),
          ),
        ),

        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/utils/number_formater.dart';

class ResendCodeButton extends StatefulWidget {
  final int duration;
  final VoidCallback onResend;
  final String buttonText;

  const ResendCodeButton({
    super.key,
    required this.duration,
    required this.onResend,
    this.buttonText = "ارسال مجدد کد",
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = widget.duration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onPressed() {
    widget.onResend();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = _remainingTime == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatNumberToPersianWithoutSeparator(_formatTime(_remainingTime)),
            style: TextStyle(
              fontSize: 12,
              color: isEnabled ? AppColors.neutral757575 : AppColors.secondary,
            ),
          ),
          TextButton(
            onPressed: isEnabled ? _onPressed : null,
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            child: Text(
              widget.buttonText,
              style: TextStyle(
                fontSize: 12,
                color: isEnabled
                    ? AppColors.secondary
                    : AppColors.neutral757575,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

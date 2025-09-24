import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/features/auth/presentation/widgets/custom_otp.dart';
import 'package:bazargan/features/auth/presentation/widgets/resend_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.primary),
          ),

          //! Logo
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    Images.bazarganWhite,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'به نرم افزار کتابخوان بازرگان خوش آمدید',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 75,
                  horizontal: 16,
                ),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  spacing: 32,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تایید تلفن همراه',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.neutralMidnight,
                      ),
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        Text(
                          'کد ۵ رقمی ارسال شده به شماره ۰۹۱۲۳۴۵۶۷۸۹ را وارد نمایید',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutral757575,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            context.go('/login');
                          },
                          child: const Text(
                            'ویرایش شماره',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      spacing: 8,
                      children: [
                        CustomOtpField(length: 5, onCompleted: (value) {}),
                        ResendCodeButton(duration: 120, onResend: () {}),
                        Button(
                          label: 'ورود',
                          width: double.infinity,
                          backgroundColor: AppColors.secondary,
                          onPressed: () {
                            context.go('/');
                          },
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: () {
                        _openTerms(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: const Text(
                          'ثبت نام در اپلیکیشن استیم به معنای پذیرش تمام قوانین و مقررات و مرام نامه حرمی خصوصی استیم است',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutral757575,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openTerms(BuildContext context) {
    showDialog(
      barrierColor: AppColors.secondaryTint3.withValues(alpha: 0.9),
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Header ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'قوانین و مقررات',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.neutralMidnight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: Icon(Iconsax.close_circle_copy, size: 30),
                      ),
                    ],
                  ),
                ),
                Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                SizedBox(height: 16),

                // --- Body ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text('توضیحات قوانین و مقررات ${index + 1}'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

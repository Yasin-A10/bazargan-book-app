import 'package:bazargan/config/router/route_paths.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/features/profile/presentation/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _walletController = TextEditingController();

  final List<int> suggestedAmounts = [50000, 100000, 200000, 500000];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _walletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حساب کاربری')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              ProfileCard(
                title: 'ارش رضاوند',
                subtitle: '۰۹۱۲۷۵۴۳۵۵۶۵',
                mainIcon: Iconsax.user_copy,
                subIcon: Iconsax.edit,
                background: AppColors.primary,
                onTap: () {
                  _openEditName(context);
                },
              ),
              ProfileCard(
                title: '۱۲۰۰۰۰ تومان',
                subtitle: 'موجودی کیف پول شما',
                mainIcon: Iconsax.wallet_copy,
                subIcon: Iconsax.add_square,
                background: AppColors.tertiary,
                onTap: () {
                  _openChargeWallet(context);
                },
              ),
              ProfileCard(
                title: '۷۶ روز باقی مانده',
                subtitle: 'از بسته ۳ ماهه اشتراک ویژه',
                mainIcon: Iconsax.polygon_matic_copy,
                subIcon: Iconsax.add_square,
                background: AppColors.secondary,
                onTap: () {},
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    ListItemWidget(
                      title: 'امتیاز من',
                      rightIcon: Icon(Iconsax.star_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {},
                    ),
                    Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ListItemWidget(
                      title: 'نظرات من',
                      rightIcon: Icon(Iconsax.messages_3_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {
                        context.push(RoutePaths.profileComments);
                      },
                    ),
                    Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ListItemWidget(
                      title: 'نشان شده ها',
                      rightIcon: Icon(Iconsax.bookmark_2_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {
                        context.push(RoutePaths.myLibraryBookmarks);
                      },
                    ),
                    Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ListItemWidget(
                      title: 'تاریخچه تراکنش‌ها',
                      rightIcon: Icon(Iconsax.clock_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {
                        context.push(RoutePaths.profileTransaction);
                      },
                    ),
                    Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ListItemWidget(
                      title: 'دسته بندی‌های مورد علاقه',
                      rightIcon: Icon(Iconsax.heart_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {
                        context.push(RoutePaths.profileFavorites);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    ListItemWidget(
                      title: 'پشتیبانی',
                      rightIcon: Icon(Iconsax.call_copy, size: 20),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      onPressed: () {
                        _openSupport(context);
                      },
                    ),
                    Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ListItemWidget(
                      title: 'خروج از حساب',
                      rightIcon: Icon(
                        Iconsax.logout_copy,
                        size: 20,
                        color: AppColors.error,
                      ),
                      leftIcon: Iconsax.arrow_left_2_copy,
                      titleStyle: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.error,
                      ),
                      onPressed: () {
                        _openLogout(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditName(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              Text(
                'ویرایش نام نمایشی',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              InputTextFormField(label: 'نام نمایشی'),
              Button(
                label: 'ذخیره',
                onPressed: () {
                  context.pop();
                },
                width: double.infinity,
                backgroundColor: AppColors.secondary,
                textColor: AppColors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  void _openChargeWallet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              Text(
                'ویرایش نام نمایشی',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                'مبلغ مورد نظر خود را وارد کنید',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.neutral757575,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Stack(
                children: [
                  Column(
                    children: [
                      InputTextFormField(
                        label: 'مبلغ',
                        keyboardType: TextInputType.number,
                        controller: _walletController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: suggestedAmounts.map((amount) {
                          return ElevatedButton(
                            onPressed: () {
                              _walletController.text = amount.toString();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: const Size(0, 32),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.secondaryTint8,
                            ),
                            child: Text(
                              formatNumberToPersian(amount),
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.secondary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 20,
                    left: 16,
                    child: SvgPicture.asset(
                      height: 24,
                      width: 24,
                      Images.tooman,
                    ),
                  ),
                ],
              ),
              Button(
                label: 'تایید و پرداخت',
                onPressed: () {
                  context.pop();
                },
                width: double.infinity,
                backgroundColor: AppColors.secondary,
                textColor: AppColors.white,
              ),
              Text(
                'در صورت داشتن کد هدیه آن‌ را وارد کنید',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.neutral757575,
                  fontWeight: FontWeight.w300,
                ),
              ),
              InputTextFormField(
                label: 'کد هدیه',
                keyboardType: TextInputType.number,
              ),
              Button(
                label: 'اعمال کد هدیه',
                onPressed: () {
                  context.pop();
                },
                width: double.infinity,
                backgroundColor: AppColors.secondaryTint8,
                textColor: AppColors.secondary,
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSupport(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              Text(
                'پشتیبانی',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Button(
                iconOnRight: true,
                label: '۰۹۱۲۳۴۵۶۷۸۹',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: AppColors.secondaryTint8,
                textColor: AppColors.secondary,
                icon: Icon(
                  Iconsax.call_copy,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
              Button(
                iconOnRight: true,
                label: '@bazargan_support',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: AppColors.secondaryTint8,
                textColor: AppColors.secondary,
                icon: Icon(
                  Iconsax.messages_copy,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
              Button(
                iconOnRight: true,
                label: 'info@bazargan.app',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: AppColors.secondaryTint8,
                textColor: AppColors.secondary,
                icon: Icon(
                  Iconsax.sms_copy,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
              Text(
                'متن پیام خود را وارد کنید',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.neutral757575,
                  fontWeight: FontWeight.w300,
                ),
              ),
              InputTextFormField(label: 'متن پیام', maxLines: 6),
              Button(
                label: 'ارسال',
                onPressed: () {
                  context.pop();
                },
                width: double.infinity,
                backgroundColor: AppColors.secondary,
                textColor: AppColors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  void _openLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 20,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              Text(
                'خروج از حساب',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
              Text(
                'آیا نسبت به خروج از حساب خود اطمینان دارید؟',
                style: AppTextStyles.small.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Button(
                      label: 'بازگشت',
                      onPressed: () {
                        context.pop();
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.secondary,
                      borderColor: AppColors.secondary,
                    ),
                  ),
                  Expanded(
                    child: Button(
                      label: 'خروج از حساب',
                      onPressed: () {
                        context.pop();
                      },
                      width: double.infinity,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

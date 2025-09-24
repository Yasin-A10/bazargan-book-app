import 'dart:ui';

import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/widgets/button/button.dart';
import 'package:bazargan/core/widgets/inputs/star_rating.dart';
import 'package:bazargan/core/widgets/inputs/text_form_field.dart';
import 'package:bazargan/core/widgets/list_item_widget.dart';
import 'package:bazargan/core/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: LinearBorder.bottom(
          side: BorderSide(
            color: !_isScrolled ? Colors.transparent : AppColors.neutralEDEDED,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          color: _isScrolled ? Colors.white : Colors.transparent,
        ),
        title: Text("مذاکره بدون ترس", style: AppTextStyles.headlineLarge),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral353535,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.more_copy,
              color: AppColors.neutral353535,
              size: 16,
            ),
            onPressed: () {
              _openMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Image.asset(Images.listImg, fit: BoxFit.cover),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.white.withValues(alpha: 0.7),
                              AppColors.white.withValues(alpha: 0.9),
                              AppColors.white.withValues(alpha: 1.0),
                            ],
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      spacing: 8,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10.8,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              Images.listImg,
                              height: 200,
                              width: 136,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.share_copy,
                                color: AppColors.secondary,
                                size: 24,
                              ),
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  Iconsax.star_1,
                                  color: AppColors.primary,
                                  size: 16,
                                ),
                                Text(
                                  '۴.۵',
                                  style: AppTextStyles.small.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                Text('(۳۲)', style: AppTextStyles.small),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Iconsax.save_2_copy,
                                color: AppColors.secondary,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text("مذاکره بدون ترس", style: AppTextStyles.headlineLarge),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BookInfoList(
                    title: "نویسنده:",
                    infos: ["فونگ ووتی تانه"],
                    hasArrow: true,
                  ),
                  BookInfoList(
                    title: "مترجم:",
                    infos: ["سیده یاسمن اشرف زاده", "محمد حسینی"],
                    hasArrow: true,
                  ),
                  BookInfoList(
                    title: "انتشارات:",
                    infos: ["چاپ و نشر بازرگانی"],
                    hasArrow: true,
                  ),
                  BookInfoList(
                    title: "دسته بندی:",
                    infos: ["روان شناسی", "فیلسوفی"],
                    hasArrow: true,
                  ),
                  BookInfoList(title: "تعداد صفحات:", infos: ["۳۲۳"]),
                  BookInfoList(title: "تاریخ انتشار:", infos: ["۱۴۰۲"]),
                  BookInfoList(title: "نوع کتاب:", infos: ["PDF"]),
                ],
              ),
            ),
            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "۲۳۷,۰۰۰",
                  style: AppTextStyles.headlineLarge.copyWith(
                    fontSize: 20,
                    color: AppColors.secondary,
                  ),
                ),
                SvgPicture.asset(Images.tooman, width: 16, height: 16),
              ],
            ),
            SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(label: 'خرید مستقیم', onPressed: () {}),
                  Expanded(
                    child: Button(
                      label: 'افزودن به سبد',
                      onPressed: () {},
                      backgroundColor: AppColors.primaryTint8,
                      textColor: AppColors.primary,
                      icon: Icon(
                        Iconsax.bag_2_copy,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                width: double.infinity,
                label: 'نمونه',
                onPressed: () {},
                icon: Icon(
                  Iconsax.book_1_copy,
                  size: 20,
                  color: AppColors.secondary,
                ),
                backgroundColor: AppColors.white,
                textColor: AppColors.secondary,
                borderColor: AppColors.secondary,
              ),
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text("معرفی کتاب", style: AppTextStyles.headlineLarge),
                  Text(
                    "کتاب الکترونیکی «مذاکره بدون ترس» از ویکتوریا اچ. مدوک و فاطمه هفت اختان و محمود رسولی و بیتا نوروزی - انتشارات چاپ و نشر بازرگانی.",
                    textAlign: TextAlign.justify,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w300,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            //TODO: Add Comments list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                label: 'افزودن نظر',
                onPressed: () {
                  _openReviewMenu(context);
                },
                width: double.infinity,
                backgroundColor: AppColors.white,
                textColor: AppColors.primary,
                borderColor: AppColors.primary,
              ),
            ),
            SizedBox(height: 24),

            ListWidget(title: 'سایر کتاب‌های این نویسنده', listHeight: 200),
            SizedBox(height: 32),

            ListWidget(title: 'سایر کتاب‌های این ناشر', listHeight: 200),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    transform: GradientRotation(0.4),
                    colors: [
                      AppColors.primary.withValues(alpha: 0.4),
                      AppColors.neutralMidnight.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: AppColors.neutral757575,
                        thickness: 3,
                        endIndent: 140,
                        indent: 140,
                      ),
                      const SizedBox(height: 16),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'فهرست کتاب',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.menu_1_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openCategoryMenu(context);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'افزودن نظر',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.messages_3_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openReviewMenu(context);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      ListItemWidget(
                        title: 'شناسنامه اثر',
                        titleStyle: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        rightIcon: Icon(
                          Iconsax.book_copy,
                          size: 20,
                          color: AppColors.neutralMidnight,
                        ),
                        leftIcon: Iconsax.arrow_left_2_copy,
                        onPressed: () {
                          _openBookInfo(context);
                        },
                      ),
                      const SizedBox(height: 8),
                      Divider(color: AppColors.neutralE3E3E3, thickness: 1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _openCategoryMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 16,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                color: AppColors.neutral757575,
                thickness: 3,
                endIndent: 140,
                indent: 140,
              ),
              const SizedBox(height: 16),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
              ListItemWidget(
                title: 'عنوان',
                titleStyle: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Divider(color: AppColors.neutralE3E3E3, thickness: 1),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _openReviewMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
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
                  'ثبت نظر',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 0),
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      'چگونه یک درون گرای تاثیر گذار باشیم',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    StarRating(
                      maxRating: 5,
                      onRatingChanged: (rating) {
                        //? Handle rating change
                      },
                    ),
                  ],
                ),
                InputTextFormField(
                  label: 'متن نظر',
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  controller: TextEditingController(),
                ),
                Button(
                  label: 'افزودن نظر',
                  onPressed: () {
                    context.pop();
                  },
                  width: double.infinity,
                  backgroundColor: AppColors.secondary,
                  textColor: AppColors.white,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openBookInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
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
                  'شناسنامه اثر',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                BookInfoList(
                  title: "نویسنده:",
                  infos: ["فونگ ووتی تانه"],
                  hasArrow: true,
                ),
                BookInfoList(
                  title: "مترجم:",
                  infos: ["سیده یاسمن اشرف زاده", "محمد حسینی"],
                  hasArrow: true,
                ),
                BookInfoList(
                  title: "انتشارات:",
                  infos: ["چاپ و نشر بازرگانی"],
                  hasArrow: true,
                ),
                BookInfoList(
                  title: "دسته بندی:",
                  infos: ["روان شناسی", "فیلسوفی"],
                  hasArrow: true,
                ),
                BookInfoList(title: "تعداد صفحات:", infos: ["۳۲۳"]),
                BookInfoList(title: "قیمت نسخه چاپی:", infos: ["۲۳۷۰۰۰ تومان"]),
                BookInfoList(title: "تاریخ انتشار:", infos: ["۱۴۰۲"]),
                BookInfoList(title: "شابک:", infos: ["۹۰۸۷۸۳۷۳۴۷۳۸۴۷۳۷۲۸"]),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BookInfoList extends StatelessWidget {
  final String title;
  final List<String> infos;
  final bool hasArrow;

  const BookInfoList({
    super.key,
    required this.title,
    required this.infos,
    this.hasArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium.copyWith(fontSize: 10)),

        const SizedBox(width: 8),
        const Expanded(
          child: Divider(color: AppColors.neutralE3E3E3, thickness: 1),
        ),
        const SizedBox(width: 8),

        ...infos.map(
          (info) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: hasArrow ? () {} : null,
              child: Row(
                children: [
                  Text(info, style: AppTextStyles.headlineMedium),
                  if (hasArrow)
                    Icon(
                      Iconsax.arrow_left_2_copy,
                      size: 16,
                      color: AppColors.neutral757575,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

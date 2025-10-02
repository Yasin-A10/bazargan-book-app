import 'package:bazargan/core/constants/texts.dart';
import 'package:bazargan/core/utils/convert_to_jalali.dart';
import 'package:bazargan/core/utils/number_formater.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';

class UserTransactionCard extends StatelessWidget {
  final String head;
  final List<String> title;
  final String date;
  final String time;
  final int price;
  final int? discount;
  final String way;
  final String code;
  final String status;
  const UserTransactionCard({
    super.key,
    required this.head,
    required this.title,
    required this.date,
    required this.time,
    required this.price,
    this.discount,
    required this.way,
    required this.code,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Text(head, style: AppTextStyles.headlineLarge.copyWith(fontSize: 12)),
          TransactionRow(title: 'عنوان:', value: title.join(', ')),
          TransactionRow(
            title: 'تاریخ و ساعت:',
            value: formatNumberToPersianWithoutSeparator(
              '${convertToJalaliTime(time)} . ${convertToJalaliDate(date)}',
            ),
          ),
          TransactionRow(
            title: 'تخفیف:',
            value: formatNumberToPersian(discount ?? 0),
          ),
          TransactionRow(title: 'قیمت:', value: formatNumberToPersian(price)),
          TransactionRow(title: 'روش پرداخت:', value: way),
          TransactionRow(
            title: 'کد پیگیری:',
            value: formatNumberToPersianWithoutSeparator(code),
          ),
          TransactionRow(
            title: 'وضعیت:',
            value: status == 'p' ? 'موفق' : 'ناموفق',
            valueColor: status == 'p' ? AppColors.success : AppColors.error,
          ),
        ],
      ),
    );
  }
}

//! Transaction Row
class TransactionRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  const TransactionRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 16,
      children: [
        Text(title, style: AppTextStyles.small),
        Expanded(
          child: const Divider(color: AppColors.neutralE3E3E3, thickness: 1),
        ),
        Text(
          value,
          style: AppTextStyles.small.copyWith(fontSize: 12, color: valueColor),
        ),
      ],
    );
  }
}

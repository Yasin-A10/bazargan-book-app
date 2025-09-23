import 'package:bazargan/features/profile_transaction/presentation/widgets/user_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileTransactionScreen extends StatelessWidget {
  const ProfileTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تاریخچه تراکنش ها'),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const UserTransactionCard(
            head: 'خرید از فروشنده',
            title: 'شازده کوچولو',
            date: '۱۳۹۴/۰۱/۰۱',
            time: '۱۲:۰۰',
            price: '۱۰۰۰۰۰',
            discount: '۱۰۰۰',
            way: 'آنلاین',
            code: '۱۲۳۴۵۶',
            status: true,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}

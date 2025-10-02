import 'package:bazargan/features/profile_transaction/presentation/bloc/transaction_bloc.dart';
import 'package:bazargan/features/profile_transaction/presentation/widgets/user_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTransactionScreen extends StatelessWidget {
  const ProfileTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionBloc = BlocProvider.of<TransactionBloc>(context);
    transactionBloc.add(LoadTransactionEvent());

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
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionError) {
            return Center(child: Text(state.error));
          }

          if (state is TransactionSuccess) {
            final transaction = state.userTransactionModel;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: transaction.results.length,
              itemBuilder: (context, index) {
                final payment = transaction.results[index];
                return UserTransactionCard(
                  head: payment.type,
                  title: payment.title,
                  date: payment.transactionCreatedAt,
                  time: payment.transactionCreatedAt,
                  price: payment.amount,
                  discount: payment.discountPercent,
                  way: payment.paymentMethod,
                  code: payment.trackingCode,
                  status: payment.status,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

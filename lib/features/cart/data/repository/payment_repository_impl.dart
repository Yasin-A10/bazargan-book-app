import 'package:bazargan/features/cart/data/model/payment_model.dart';
import 'package:bazargan/features/cart/data/source/payment_api_provider.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl {
  final PaymentApiProvider apiProvider;

  PaymentRepositoryImpl({required this.apiProvider});

  Future<Either<String, Map<String, dynamic>>> addPayment(
    String cartId,
    PaymentModel paymentModel,
  ) async {
    try {
      final result = await apiProvider.addPayment(cartId, paymentModel);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}

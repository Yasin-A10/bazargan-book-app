import 'package:bazargan/features/cart/data/model/coupon_result_model.dart';
import 'package:bazargan/features/cart/data/source/coupon_api_provider.dart';
import 'package:dartz/dartz.dart';

class CouponRepositoryImpl {
  final CouponApiProvider apiProvider;

  CouponRepositoryImpl({required this.apiProvider});

  Future<Either<String, CouponResultModel>> addCoupon(
    String cartId,
    String couponCode,
  ) async {
    try {
      final result = await apiProvider.addCoupon(cartId, couponCode);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}

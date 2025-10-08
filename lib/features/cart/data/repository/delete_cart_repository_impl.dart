import 'package:bazargan/features/cart/data/source/delete_cart_api_provider.dart';
import 'package:dartz/dartz.dart';

class DeleteCartRepositoryImpl {
  final DeleteCartApiProvider apiProvider;

  DeleteCartRepositoryImpl({required this.apiProvider});

  Future<Either<String, dynamic>> deleteCart(int cartId) async {
    try {
      final result = await apiProvider.deleteCart(cartId);
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}

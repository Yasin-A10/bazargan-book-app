import 'package:bazargan/features/cart/data/model/cart_model.dart';
import 'package:bazargan/features/cart/data/source/cart_api_provider.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl {
  final CartApiProvider apiProvider;

  CartRepositoryImpl({required this.apiProvider});

  Future<Either<String, CartModel>> getCart() async {
    try {
      final result = await apiProvider.getCart();
      return Right(result);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }
}

import 'package:bazargan/features/book/data/source/add_to_cart_api_provider.dart';
import 'package:dartz/dartz.dart';

class AddToCartRepositoryImpl {
  final AddToCartApiProvider apiProvider;

  AddToCartRepositoryImpl({required this.apiProvider});

  Future<Either<String, String>> addToCart(int bookId) async {
    try {
      final result = await apiProvider.addToCart(bookId);
      final message = result['message'] ?? 'با موفقیت اضافه شد';
      return Right(message);
    } catch (e) {
      return Left("ارور بخش ریپازیتوری ${e.toString()}");
    }
  }

  // Future<Either<String, dynamic>> addToCart(int bookId) async {
  //   try {
  //     final result = await apiProvider.addToCart(bookId);
  //     return Right(result);
  //   } catch (e) {
  //     return Left("ارور بخش ریپازیتوری ${e.toString()}");
  //   }
  // }
}

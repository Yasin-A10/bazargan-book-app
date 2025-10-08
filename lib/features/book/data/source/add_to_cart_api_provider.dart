import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

class AddToCartApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> addToCart(int bookId) async {
    try {
      final response = await _apiClient.post(
        '$baseUrl/transaction-api/cart-item/',
        data: {'book': bookId},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('خطا در اضافه کردن به سبد خرید: ${response.data}');
      }
      return response.data;
    } catch (e) {
      throw Exception('ارور بخش سورس: ${e.toString()}');
    }
  }
}

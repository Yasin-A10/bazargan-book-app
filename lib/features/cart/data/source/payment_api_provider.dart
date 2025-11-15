import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/cart/data/model/payment_model.dart';

class PaymentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<Map<String, dynamic>> addPayment(
    String cartId,
    PaymentModel paymentModel,
  ) async {
    try {
      final response = await _apiClient.post(
        '$baseUrl/transaction-api/cart/$cartId/submit_order/',
        data: paymentModel.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data;
      }

      throw Exception("پاسخ غیرمنتظره از سرور: ${response.statusCode}");
    } catch (e) {
      throw Exception('خطا در ارسال پرداخت: ${e.toString()}');
    }
  }
}

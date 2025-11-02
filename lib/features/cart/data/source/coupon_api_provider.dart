import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/cart/data/model/coupon_result_model.dart';

class CouponApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<CouponResultModel> addCoupon(String cartId, String couponCode) async {
    try {
      final response = await _apiClient.post(
        '$baseUrl/transaction-api/cart/$cartId/submit_coupon/',
        data: {'coupon': couponCode},
      );

      if (response.statusCode == 200 && response.data != null) {
        return CouponResultModel.fromJson(response.data);
      }

      throw Exception("پاسخ غیرمنتظره از سرور: ${response.statusCode}");
    } catch (e) {
      throw Exception('خطا در ارسال کد تخفیف: ${e.toString()}');
    }
  }
}

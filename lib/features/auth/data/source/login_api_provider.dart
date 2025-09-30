import 'package:bazargan/features/auth/data/model/login_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bazargan/core/constants/api_info.dart';

class LoginApiProvider {
  final Dio _dio = Dio();

  LoginApiProvider() {
    _dio.options.baseUrl = ApiInfo.baseUrl;

    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
  }

  Future<LoginModel> loginWithOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/sms-login/',
        data: {'phone_number': phone, 'code': code},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginModel.fromJson(response.data);
        return loginResponse;
      } else {
        throw Exception('خطا در ورود: ${response.data['error']}');
      }
    } on DioException catch (e) {
      throw Exception(
        'خطا در ارسال درخواست لاگین: ${e.response?.data ?? e.message}',
      );
    }
  }
}

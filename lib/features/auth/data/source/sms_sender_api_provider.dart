import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bazargan/core/constants/api_info.dart';

class SmsSenderApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = ApiInfo.baseUrl;

  SmsSenderApiProvider() {
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

  Future<dynamic> sendSms(String phoneNumber) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/sms-sender/',
        data: {'phone_number': phoneNumber, "type": "log"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('خطا در ارسال پیام: ${response.data['error']}');
      }
    } catch (e) {
      throw Exception('خطا در ارسال درخواست پیام: $e');
    }
  }
}

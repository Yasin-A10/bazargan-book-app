// class HomeApiProvider {
//   final AuthApiClient _apiClient = AuthApiClient();
//   // final String baseUrl = ApiInfo.baseUrl;

//   Future<HomePageModel> getHomePage() async {
//     final response = await _apiClient.get('/core-api/pages/home/');
//     try {
//       return HomePageModel.fromJson(response.data);
//     } catch (e) {
//       // throw Exception('Failed to get content post... ${e.toString()}');
//       throw Exception('${response.data['error']}');
//     }
//   }
// }

import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bazargan/core/constants/api_info.dart';

class HomeApiProvider {
  final Dio _dio = Dio();

  HomeApiProvider() {
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

  Future<HomePageModel> getHomePage() async {
    try {
      final response = await _dio.get('/core-api/pages/home/');

      if (response.statusCode == 200) {
        return HomePageModel.fromJson(response.data);
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

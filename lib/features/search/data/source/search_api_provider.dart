import 'package:bazargan/features/search/data/models/search_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:bazargan/core/constants/api_info.dart';

class SearchApiProvider {
  final Dio _dio = Dio();

  SearchApiProvider() {
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

  Future<SearchModel> getSearch(String search) async {
    try {
      final response = await _dio.get(
        '/core-api/search/',
        queryParameters: {'search': search},
      );

      if (response.statusCode == 200) {
        return SearchModel.fromJson(response.data);
      } else {
        throw Exception('خطا در جستوجو: ${response.data['error']}');
      }
    } on DioException catch (e) {
      throw Exception(
        'خطا در درخواست جستوجو: ${e.response?.data ?? e.message}',
      );
    }
  }
}

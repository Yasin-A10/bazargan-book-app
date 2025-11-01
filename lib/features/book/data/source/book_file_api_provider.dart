import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:dio/dio.dart';

class BookFileApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> getBookFile(
    int bookId, {
    required Function(int received, int total) onProgress,
  }) async {
    final response = await _apiClient.get(
      '$baseUrl/content-api/files/$bookId/',
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: onProgress,
    );
    try {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception(
        'ارور بخش سورس: ${response.data['message']}, ${e.toString()}',
      );
    }
  }
}

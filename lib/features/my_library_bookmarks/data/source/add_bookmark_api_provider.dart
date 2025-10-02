import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

class AddBookmarkApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<Map<String, dynamic>> addBookmark(int bookId) async {
    try {
      final response = await _apiClient.post(
        '$baseUrl/book-api/site/books/$bookId/mark_book/',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('ارور بخش سورس ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('ارور بخش سورس ${e.toString()}');
    }
  }
}

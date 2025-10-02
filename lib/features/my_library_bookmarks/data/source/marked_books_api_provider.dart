import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/my_library_bookmarks/data/model/marked_books_model.dart';

class MarkedBooksApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<MarkedBooksModel> getMarkedBooks() async {
    final response = await _apiClient.get(
      '$baseUrl/core-api/users/marked_books/',
    );
    try {
      if (response.statusCode == 200) {
        return MarkedBooksModel.fromJson(response.data);
      } else {
        throw Exception('ارور بخش سورس ${response.data['error']}');
      }
    } catch (_) {
      throw Exception('ارور بخش سورس ${response.data['error']}');
    }
  }
}

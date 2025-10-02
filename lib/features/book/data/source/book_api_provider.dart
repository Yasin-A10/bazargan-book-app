import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/book/data/model/book_model.dart';

class BookApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<BookModel> getBook(int bookId) async {
    final response = await _apiClient.get(
      '$baseUrl/book-api/site/books/$bookId/',
    );
    try {
      if (response.statusCode == 200) {
        return BookModel.fromJson(response.data);
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

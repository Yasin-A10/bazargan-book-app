import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/book/data/model/book_comment_modle.dart';

class BookCommentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<BookCommentsModel> getBookComments(int bookId) async {
    final response = await _apiClient.get(
      '$baseUrl/book-api/site/books/$bookId/comments/',
    );
    try {
      if (response.statusCode == 200) {
        return BookCommentsModel.fromJson(response.data);
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

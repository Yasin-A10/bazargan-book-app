import 'package:bazargan/core/api/all_books.dart/data/model/all_books_model.dart';
import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

//? /book-api/site/books/? search=string & author=string & publisher=string & price=string & categories=string & type=string & translator=string & exclude=9508.141777059012 & narrator=string & customized=string & is_in_infinity=string & ordering=string

class AllBooksApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<BookListModel> getAllBook(AllBooksQuery? query) async {
    final response = await _apiClient.get(
      '$baseUrl/book-api/site/books/',
      queryParams: query?.toQueryParams(),
    );

    try {
      if (response.statusCode == 200) {
        return BookListModel.fromJson(response.data);
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

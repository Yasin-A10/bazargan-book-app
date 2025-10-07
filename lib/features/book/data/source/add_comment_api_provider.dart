import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/book/data/model/add_comment_model.dart';

class AddCommentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<AddCommentModel> addComment(
    int bookId,
    AddCommentModel addCommentModel,
  ) async {
    final response = await _apiClient.post(
      '$baseUrl/book-api/site/books/$bookId/comments/',
      data: addCommentModel.toJson(),
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddCommentModel.fromJson(response.data);
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

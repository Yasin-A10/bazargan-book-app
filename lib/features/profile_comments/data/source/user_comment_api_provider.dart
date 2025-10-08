import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/profile_comments/data/model/user_comment_model.dart';

class UserCommentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UserCommentModel> getUserComments() async {
    final response = await _apiClient.get(
      '$baseUrl/interaction-api/my-comments/',
    );
    try {
      if (response.statusCode == 200) {
        return UserCommentModel.fromJson(response.data);
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

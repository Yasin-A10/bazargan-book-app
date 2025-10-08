import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/profile_comments/data/model/update_comment_model.dart';

class UpdateCommentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UpdateCommentModel> updateComment(
    int commentId,
    UpdateCommentModel updateCommentModel,
  ) async {
    final response = await _apiClient.patch(
      '$baseUrl/interaction-api/my-comments/$commentId/',
      data: updateCommentModel.toJson(),
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateCommentModel.fromJson(response.data);
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

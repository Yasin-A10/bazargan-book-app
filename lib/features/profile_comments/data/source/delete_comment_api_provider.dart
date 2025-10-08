import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

class DeleteCommentApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<dynamic> deleteComment(int commentId) async {
    try {
      final response = await _apiClient.delete(
        '$baseUrl/interaction-api/my-comments/$commentId/',
      );

      if (response.statusCode == 204) {
        return {"message": "آیتم با موفقیت حذف شد."};
      }

      if (response.data is Map<String, dynamic>) {
        return response.data;
      }

      throw Exception("پاسخ غیرمنتظره از سرور");
    } catch (e) {
      throw Exception('ارور بخش سورس: ${e.toString()}');
    }
  }
}

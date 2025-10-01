import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

class AddFavoriteApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<Map<String, dynamic>> addFavorite(List<int> categoryIds) async {
    try {
      final body = {"fav_categories": categoryIds};
      final response = await _apiClient.post(
        '$baseUrl/auth/fav-categories/',
        data: body,
      );
      return response.data;
    } catch (e) {
      throw Exception('ارور بخش سورس ${e.toString()}');
    }
  }
}

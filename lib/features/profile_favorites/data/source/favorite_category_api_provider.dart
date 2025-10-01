import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/profile_favorites/data/model/favorite_category_model.dart';

class FavoriteCategoryApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<FavoriteCategoryModel> getFavoriteCategories() async {
    final response = await _apiClient.get('$baseUrl/auth/fav-categories/');
    try {
      if (response.statusCode == 200) {
        return FavoriteCategoryModel.fromJson(response.data);
      } else {
        throw Exception(response.data['error']);
      }
    } catch (_) {
      throw Exception('${response.data['error']}');
    }
  }
}

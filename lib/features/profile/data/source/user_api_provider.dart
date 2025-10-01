import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/profile/data/model/user_model.dart';

class UserApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UserModel> getUser() async {
    final response = await _apiClient.get('$baseUrl/core-api/users/me/');
    try {
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(response.data['error']);
      }
    } catch (_) {
      throw Exception('${response.data['error']}');
    }
  }
}

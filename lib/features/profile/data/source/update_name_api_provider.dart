import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';

class UpdateNameApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<Map<String, dynamic>> updateName(String name) async {
    try {
      final body = {'display_name': name};
      final response = await _apiClient.patch(
        '$baseUrl/core-api/users/me/',
        data: body,
      );
      return response.data;
    } catch (e) {
      throw Exception('ارور بخش سورس ${e.toString()}');
    }
  }
}

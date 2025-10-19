import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/my_library/data/models/my_library_model.dart';

class MyLibraryApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<MyLibraryModel> getMyLibrary() async {
    final response = await _apiClient.get('$baseUrl/core-api/users/my_books/');
    try {
      if (response.statusCode == 200) {
        return MyLibraryModel.fromJson(response.data);
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

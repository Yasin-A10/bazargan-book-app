import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/profile_transaction/data/model/user_transaction_model.dart';

class UserTransactionApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<UserTransactionModel> getUserTransaction() async {
    final response = await _apiClient.get(
      '$baseUrl/core-api/users/me/transactions/',
    );
    try {
      if (response.statusCode == 200) {
        return UserTransactionModel.fromJson(response.data);
      } else {
        throw Exception('ارور بخش سورس ${response.data['error']}');
      }
    } catch (_) {
      throw Exception('ارور بخش سورس ${response.data['error']}');
    }
  }
}

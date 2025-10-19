import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/book/data/model/audio_book_model.dart';

class AudioBookApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<List<AudioBookModel>> getAudioBookLinks(int childBookId) async {
    final response = await _apiClient.get(
      '$baseUrl/book-api/admin/audiobooks/$childBookId/links/',
    );
    
    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((e) => AudioBookModel.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'خطای نامشخص');
      }
    } catch (e) {
      throw Exception('ارور بخش سورس: ${e.toString()}');
    }
  }
}

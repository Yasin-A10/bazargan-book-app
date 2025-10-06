import 'package:bazargan/core/constants/api_info.dart';
import 'package:bazargan/core/network/auth_api_client.dart';
import 'package:bazargan/features/book/data/model/feedback_model.dart';

class FeedbackApiProvider {
  final AuthApiClient _apiClient = AuthApiClient();
  final String baseUrl = ApiInfo.baseUrl;

  Future<FeedbackModel> addFeedback(
    int bookId,
    int commentId,
    FeedbackModel feedbackModel,
  ) async {
    final response = await _apiClient.post(
      '$baseUrl/book-api/site/books/$bookId/comments/$commentId/feedback/',
      data: feedbackModel.toJson(),
    );
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return FeedbackModel.fromJson(response.data);
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

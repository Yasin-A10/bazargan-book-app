import 'package:bazargan/features/book/data/model/audio_book_model.dart';
import 'package:bazargan/features/book/data/source/audio_book_api_provider.dart';
import 'package:dartz/dartz.dart';

class AudioBookRepositoryImpl {
  final AudioBookApiProvider apiProvider;

  AudioBookRepositoryImpl({required this.apiProvider});

  Future<Either<String, List<AudioBookModel>>> getAudioBookLinks(
    int childBookId,
  ) async {
    try {
      final result = await apiProvider.getAudioBookLinks(childBookId);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

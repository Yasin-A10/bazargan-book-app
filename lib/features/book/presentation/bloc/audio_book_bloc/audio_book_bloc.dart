import 'package:bazargan/features/book/data/model/audio_book_model.dart';
import 'package:bazargan/features/book/data/repository/audio_book_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_book_state.dart';
part 'audio_book_event.dart';

class AudioBookBloc extends Bloc<AudioBookEvent, AudioBookState> {
  final AudioBookRepositoryImpl audioBookRepository;

  AudioBookBloc({required this.audioBookRepository})
    : super(AudioBookInitial()) {
    // get audio book
    on<LoadAudioBookLinks>((event, emit) async {
      emit(AudioBookLoading());

      try {
        final Either<String, List<AudioBookModel>> result =
            await audioBookRepository.getAudioBookLinks(event.childBookId);

        result.fold(
          (error) => emit(AudioBookError(message: error)),
          (audioBooks) => emit(AudioBookSuccess(audioBooks: audioBooks)),
        );
      } catch (e) {
        emit(AudioBookError(message: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}

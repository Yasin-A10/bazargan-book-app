import 'package:bazargan/features/my_library_bookmarks/data/model/marked_books_model.dart';
import 'package:bazargan/features/my_library_bookmarks/data/repository/add_bookmark_repository_impl.dart';
import 'package:bazargan/features/my_library_bookmarks/data/repository/marked_books_repository_impl.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/add_marked_book_status.dart';
import 'package:bazargan/features/my_library_bookmarks/presentation/bloc/load_marked_book_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'marked_books_event.dart';
part 'marked_books_state.dart';

class MarkedBooksBloc extends Bloc<MarkedBooksEvent, MarkedBooksState> {
  final MarkedBooksRepositoryImpl markedBooksRepository;
  final AddBookmarkRepositoryImpl addBookmarkRepository;

  MarkedBooksBloc({
    required this.markedBooksRepository,
    required this.addBookmarkRepository,
  }) : super(
         MarkedBooksState(
           loadMarkedBooksStatus: MarkedBooksInitial(),
           addMarkedBookStatus: AddMarkedBookInitial(),
         ),
       ) {
    on<LoadMarkedBooksEvent>((event, emit) async {
      emit(
        state.copyWith(
          newLoadMarkedBooksStatus: MarkedBooksLoading(),
          newAddMarkedBookStatus: AddMarkedBookInitial(),
        ),
      );

      final Either<String, MarkedBooksModel> dataState =
          await markedBooksRepository.getMarkedBooks();

      dataState.fold(
        (left) => emit(
          state.copyWith(
            newLoadMarkedBooksStatus: MarkedBooksError(error: left),
          ),
        ),
        (right) => emit(
          state.copyWith(
            newLoadMarkedBooksStatus: MarkedBooksSuccess(
              markedBooksModel: right,
            ),
          ),
        ),
      );
    });

    on<AddBookmarkEvent>((event, emit) async {
      emit(state.copyWith(newAddMarkedBookStatus: AddMarkedBookLoading()));

      final Either<String, dynamic> dataState = await addBookmarkRepository
          .addBookmark(event.bookId);

      await dataState.fold(
        (left) async {
          emit(
            state.copyWith(
              newAddMarkedBookStatus: AddMarkedBookError(error: left),
            ),
          );
        },
        (right) async {
          emit(
            state.copyWith(
              newAddMarkedBookStatus: AddMarkedBookSuccess(bookmark: right),
            ),
          );

          final Either<String, MarkedBooksModel> refreshed =
              await markedBooksRepository.getMarkedBooks();

          refreshed.fold(
            (left) => emit(
              state.copyWith(
                newAddMarkedBookStatus: AddMarkedBookInitial(),
                newLoadMarkedBooksStatus: MarkedBooksError(error: left),
              ),
            ),
            (right) => emit(
              state.copyWith(
                newAddMarkedBookStatus: AddMarkedBookInitial(),
                newLoadMarkedBooksStatus: MarkedBooksSuccess(
                  markedBooksModel: right,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

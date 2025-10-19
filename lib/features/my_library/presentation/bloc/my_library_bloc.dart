import 'package:bazargan/features/my_library/data/models/my_library_model.dart';
import 'package:bazargan/features/my_library/data/repository/my_library_repository_impl.dart';
import 'package:bazargan/features/my_library/presentation/bloc/load_my_books_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'my_library_event.dart';
part 'my_library_state.dart';

class MyLibraryBloc extends Bloc<MyLibraryEvent, MyLibraryState> {
  final MyLibraryRepositoryImpl myLibraryRepository;

  MyLibraryBloc({required this.myLibraryRepository})
    : super(MyLibraryState(loadMyBooksStatus: MyLibraryInitial())) {
    // get cart
    on<LoadMyLibraryEvent>((event, emit) async {
      emit(state.copyWith(newLoadMyBooksStatus: MyLibraryLoading()));

      final Either<String, MyLibraryModel> dataState = await myLibraryRepository
          .getMyLibrary();

      dataState.fold(
        (left) => emit(
          state.copyWith(newLoadMyBooksStatus: MyLibraryError(error: left)),
        ),
        (right) => emit(
          state.copyWith(
            newLoadMyBooksStatus: MyLibrarySuccess(myLibraryModel: right),
          ),
        ),
      );
    });
  }
}

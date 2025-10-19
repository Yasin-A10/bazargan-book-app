part of 'my_library_bloc.dart';

class MyLibraryState {
  final LoadMyBooksStatus loadMyBooksStatus;

  MyLibraryState({required this.loadMyBooksStatus});

  MyLibraryState copyWith({LoadMyBooksStatus? newLoadMyBooksStatus}) {
    return MyLibraryState(
      loadMyBooksStatus: newLoadMyBooksStatus ?? loadMyBooksStatus,
    );
  }
}

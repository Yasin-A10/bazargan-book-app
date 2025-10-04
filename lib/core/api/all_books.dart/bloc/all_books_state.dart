part of 'all_books_bloc.dart';

@immutable
class AllBooksState {}

class AllBooksInitial extends AllBooksState {}

class AllBooksLoading extends AllBooksState {}

class AllBooksSuccess extends AllBooksState {
  final BookListModel bookListModel;

  AllBooksSuccess({required this.bookListModel});
}

class AllBooksError extends AllBooksState {
  final String error;

  AllBooksError({required this.error});
}

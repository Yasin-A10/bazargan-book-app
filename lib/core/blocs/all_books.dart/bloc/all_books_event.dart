part of 'all_books_bloc.dart';

@immutable
class AllBooksEvent {}

class LoadAllBooksEvent extends AllBooksEvent {
  final AllBooksQuery? query;

  LoadAllBooksEvent({this.query});
}

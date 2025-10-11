part of 'marked_books_bloc.dart';

class MarkedBooksState {
  final LoadMarkedBooksStatus loadMarkedBooksStatus;
  final AddMarkedBookStatus addMarkedBookStatus;

  MarkedBooksState({
    required this.loadMarkedBooksStatus,
    required this.addMarkedBookStatus,
  });

  MarkedBooksState copyWith({
    LoadMarkedBooksStatus? newLoadMarkedBooksStatus,
    AddMarkedBookStatus? newAddMarkedBookStatus,
  }) {
    return MarkedBooksState(
      loadMarkedBooksStatus: newLoadMarkedBooksStatus ?? loadMarkedBooksStatus,
      addMarkedBookStatus: newAddMarkedBookStatus ?? addMarkedBookStatus,
    );
  }
}

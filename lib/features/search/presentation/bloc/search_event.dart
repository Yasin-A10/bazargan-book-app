part of 'search_bloc.dart';

abstract class SearchEvent {}

class LoadSearchEvent extends SearchEvent {
  final String search;

  LoadSearchEvent({required this.search});
}

class ClearSearchEvent extends SearchEvent {}

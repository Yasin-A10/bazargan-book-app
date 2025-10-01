part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchModel searchModel;
  SearchSuccess({required this.searchModel});
}

class SearchError extends SearchState {
  final String error;
  SearchError({required this.error});
}

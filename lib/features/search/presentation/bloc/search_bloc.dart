import 'package:bazargan/features/search/data/repository/search_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/features/search/data/models/search_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepositoryImpl repository;

  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<ClearSearchEvent>((event, emit) {
      emit(SearchInitial());
    });

    on<LoadSearchEvent>((event, emit) async {
      if (event.search.trim().isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final Either<String, SearchModel> result = await repository.getSearch(
          event.search,
        );

        result.fold(
          (error) => emit(SearchError(error: error)),
          (searchModel) => emit(SearchSuccess(searchModel: searchModel)),
        );
      } catch (e) {
        emit(SearchError(error: 'Unexpected error: ${e.toString()}'));
      }
    });
  }
}

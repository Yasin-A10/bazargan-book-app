import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:bazargan/features/home/data/model/home_page_model.dart';
import 'package:bazargan/features/home/data/repository/home_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImpl repository;

  HomeBloc({required this.repository}) : super(HomeLoading()) {
    on<LoadHomeEvent>((event, emit) async {
      emit(HomeLoading());

      try {
        final Either<String, HomePageModel> result = await repository
            .getHomePage();

        result.fold(
          (error) => emit(HomeError(message: error)),
          (homePageModel) => emit(HomeSuccess(homePageModel: homePageModel)),
        );
      } catch (e) {
        emit(HomeError(message: 'Unexpected error: ${e.toString()}'));
      }
    });
  }
}

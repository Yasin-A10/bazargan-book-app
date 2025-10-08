import 'package:bazargan/features/book/data/repository/add_to_cart_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_to_cart_state.dart';
part 'add_to_cart_event.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCartRepositoryImpl addToCartRepository;

  AddToCartBloc({required this.addToCartRepository})
    : super(AddToCartInitial()) {
    on<AddToCartRequestEvent>((event, emit) async {
      emit(AddToCartLoading());
      try {
        final Either<String, dynamic> result = await addToCartRepository
            .addToCart(event.bookId);

        result.fold(
          (error) => emit(AddToCartError(error: error)),
          (response) => emit(AddToCartSuccess(response: response)),
        );
      } catch (e) {
        emit(AddToCartError(error: 'ارور بخش بلاک ${e.toString()}'));
      }
    });
  }
}

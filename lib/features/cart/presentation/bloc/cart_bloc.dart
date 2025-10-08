// import 'package:bazargan/features/cart/data/model/cart_model.dart';
// import 'package:bazargan/features/cart/data/repository/cart_repository_impl.dart';
// import 'package:bazargan/features/cart/presentation/bloc/delete_cart_status.dart';
// import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';

// part 'cart_event.dart';
// part 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartRepositoryImpl cartRepository;

//   CartBloc({required this.cartRepository})
//     : super(CartState(loadCartStatus: CartInitial())) {
//     on<LoadCartEvent>((event, emit) async {
//       emit(state.copyWith(newLoadCartStatus: CartLoading()));

//       Either<String, CartModel> dataState = await cartRepository.getCart();

//       dataState.fold(
//         (left) =>
//             emit(state.copyWith(newLoadCartStatus: CartError(error: left))),
//         (right) => emit(
//           state.copyWith(newLoadCartStatus: CartSuccess(cartModel: right)),
//         ),
//       );
//     });
//   }
// }

import 'package:bazargan/features/cart/data/model/cart_model.dart';
import 'package:bazargan/features/cart/data/repository/cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/delete_cart_repository_impl.dart';
import 'package:bazargan/features/cart/presentation/bloc/delete_cart_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImpl cartRepository;
  final DeleteCartRepositoryImpl deleteCartRepository;

  CartBloc({required this.cartRepository, required this.deleteCartRepository})
    : super(
        CartState(
          loadCartStatus: CartInitial(),
          deleteCartStatus: DeleteCartInitial(),
        ),
      ) {
    /// 📦 رویداد دریافت لیست سبد خرید
    on<LoadCartEvent>((event, emit) async {
      emit(
        state.copyWith(
          newLoadCartStatus: CartLoading(),
          newDeleteCartStatus: DeleteCartInitial(),
        ),
      );

      final Either<String, CartModel> dataState = await cartRepository
          .getCart();

      dataState.fold(
        (left) =>
            emit(state.copyWith(newLoadCartStatus: CartError(error: left))),
        (right) => emit(
          state.copyWith(newLoadCartStatus: CartSuccess(cartModel: right)),
        ),
      );
    });

    /// 🗑️ رویداد حذف آیتم از سبد خرید
    on<DeleteCartEvent>((event, emit) async {
      emit(state.copyWith(newDeleteCartStatus: DeleteCartLoading()));

      final Either<String, dynamic> dataState = await deleteCartRepository
          .deleteCart(event.cartId);

      await dataState.fold(
        (left) async {
          emit(
            state.copyWith(newDeleteCartStatus: DeleteCartError(error: left)),
          );
        },
        (right) async {
          emit(
            state.copyWith(
              newDeleteCartStatus: DeleteCartSuccess(result: right),
            ),
          );

          /// بعد از حذف موفق، سبد خرید را مجدداً لود کن
          final Either<String, CartModel> refreshed = await cartRepository
              .getCart();

          refreshed.fold(
            (left) =>
                emit(state.copyWith(newLoadCartStatus: CartError(error: left))),
            (right) => emit(
              state.copyWith(newLoadCartStatus: CartSuccess(cartModel: right)),
            ),
          );
        },
      );
    });
  }
}

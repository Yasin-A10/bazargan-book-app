import 'package:bazargan/features/cart/data/model/cart_model.dart';
import 'package:bazargan/features/cart/data/model/coupon_result_model.dart';
import 'package:bazargan/features/cart/data/repository/cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/coupon_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/delete_cart_repository_impl.dart';
import 'package:bazargan/features/cart/presentation/bloc/add_coupon_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/delete_cart_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImpl cartRepository;
  final DeleteCartRepositoryImpl deleteCartRepository;
  final CouponRepositoryImpl couponRepository;

  CartBloc({
    required this.cartRepository,
    required this.deleteCartRepository,
    required this.couponRepository,
  }) : super(
         CartState(
           loadCartStatus: CartInitial(),
           deleteCartStatus: DeleteCartInitial(),
           addCouponStatus: AddCouponInitial(),
         ),
       ) {
    // get cart
    on<LoadCartEvent>((event, emit) async {
      emit(
        state.copyWith(
          newLoadCartStatus: CartLoading(),
          newDeleteCartStatus: DeleteCartInitial(),
          newAddCouponStatus: AddCouponInitial(),
          newCouponResult: null,
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

    // delete cart
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
              newCouponResult: null,
              newAddCouponStatus: AddCouponInitial(),
            ),
          );

          // refresh cart
          final Either<String, CartModel> refreshed = await cartRepository
              .getCart();

          refreshed.fold(
            (left) => emit(
              state.copyWith(
                newLoadCartStatus: CartError(error: left),
                newCouponResult: null,
              ),
            ),
            (right) => emit(
              state.copyWith(
                newLoadCartStatus: CartSuccess(cartModel: right),
                newCouponResult: null,
              ),
            ),
          );
        },
      );
    });

    // add coupon
    on<AddCouponEvent>((event, emit) async {
      emit(
        state.copyWith(
          newAddCouponStatus: AddCouponLoading(),
          newCouponResult: null,
          newDeleteCartStatus: DeleteCartInitial(),
        ),
      );

      final Either<String, CouponResultModel> dataState = await couponRepository
          .addCoupon(event.cartId, event.couponCode);

      dataState.fold(
        (left) {
          emit(state.copyWith(newAddCouponStatus: AddCouponError(error: left)));
        },
        (right) {
          emit(
            state.copyWith(
              newAddCouponStatus: AddCouponSuccess(result: right),
              newCouponResult: right,
              newDeleteCartStatus: DeleteCartInitial(),
            ),
          );
        },
      );
    });
    // on<AddCouponEvent>((event, emit) async {
    //   emit(state.copyWith(newAddCouponStatus: AddCouponLoading()));

    //   final Either<String, CouponResultModel> dataState = await couponRepository
    //       .addCoupon(event.cartId, event.couponCode);

    //   await dataState.fold(
    //     (left) async {
    //       emit(state.copyWith(newAddCouponStatus: AddCouponError(error: left)));
    //     },
    //     (right) async {
    //       emit(
    //         state.copyWith(newAddCouponStatus: AddCouponSuccess(result: right)),
    //       );

    //       // refresh cart
    //       final Either<String, CartModel> refreshed = await cartRepository
    //           .getCart();

    //       refreshed.fold(
    //         (left) =>
    //             emit(state.copyWith(newLoadCartStatus: CartError(error: left))),
    //         (right) => emit(
    //           state.copyWith(newLoadCartStatus: CartSuccess(cartModel: right)),
    //         ),
    //       );
    //     },
    //   );
    // });
  }
}

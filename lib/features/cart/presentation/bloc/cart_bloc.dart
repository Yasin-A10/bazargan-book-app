import 'package:bazargan/features/cart/data/model/cart_model.dart';
import 'package:bazargan/features/cart/data/model/coupon_result_model.dart';
import 'package:bazargan/features/cart/data/model/payment_model.dart';
import 'package:bazargan/features/cart/data/repository/cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/coupon_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/delete_cart_repository_impl.dart';
import 'package:bazargan/features/cart/data/repository/payment_repository_impl.dart';
import 'package:bazargan/features/cart/presentation/bloc/add_coupon_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/delete_cart_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/load_cart_status.dart';
import 'package:bazargan/features/cart/presentation/bloc/payment_status.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImpl cartRepository;
  final DeleteCartRepositoryImpl deleteCartRepository;
  final CouponRepositoryImpl couponRepository;
  final PaymentRepositoryImpl paymentRepository;

  CartBloc({
    required this.cartRepository,
    required this.deleteCartRepository,
    required this.couponRepository,
    required this.paymentRepository,
  }) : super(
         CartState(
           loadCartStatus: CartInitial(),
           deleteCartStatus: DeleteCartInitial(),
           addCouponStatus: AddCouponInitial(),
           paymentStatus: PaymentInitial(),
         ),
       ) {
    // get carts
    on<LoadCartEvent>((event, emit) async {
      emit(
        state.copyWith(
          newLoadCartStatus: CartLoading(),
          newDeleteCartStatus: DeleteCartInitial(),
          newAddCouponStatus: AddCouponInitial(),
          newPaymentStatus: PaymentInitial(),
          newCouponResult: null,
          setCouponResult: true,
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

      final deleteEither = await deleteCartRepository.deleteCart(event.cartId);

      late final Either<String, CartModel> cartEither;

      await deleteEither.fold(
        (error) async {
          emit(
            state.copyWith(newDeleteCartStatus: DeleteCartError(error: error)),
          );
          cartEither = Left(error);
        },
        (right) async {
          emit(
            state.copyWith(
              newDeleteCartStatus: DeleteCartSuccess(result: right),
            ),
          );

          cartEither = await cartRepository.getCart();
        },
      );

      cartEither.fold(
        (error) =>
            emit(state.copyWith(newLoadCartStatus: CartError(error: error))),
        (cartModel) => emit(
          state.copyWith(
            newLoadCartStatus: CartSuccess(cartModel: cartModel),
            newCouponResult: null,
            setCouponResult: true,
            newAddCouponStatus: AddCouponInitial(),
            newPaymentStatus: PaymentInitial(),
          ),
        ),
      );
    });

    // add coupon
    on<AddCouponEvent>((event, emit) async {
      emit(
        state.copyWith(
          newAddCouponStatus: AddCouponLoading(),
          newCouponResult: null,
          setCouponResult: true,
          newDeleteCartStatus: DeleteCartInitial(),
          newPaymentStatus: PaymentInitial(),
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
              setCouponResult: true,
              newDeleteCartStatus: DeleteCartInitial(),
            ),
          );
        },
      );
    });

    // remove coupon
    on<RemoveCouponEvent>((event, emit) async {
      emit(
        state.copyWith(
          newAddCouponStatus: AddCouponInitial(),
          newCouponResult: null,
          setCouponResult: true,
          newPaymentStatus: PaymentInitial(),
        ),
      );

      // refresh cart
      final Either<String, CartModel> refreshed = await cartRepository
          .getCart();

      refreshed.fold(
        (left) =>
            emit(state.copyWith(newLoadCartStatus: CartError(error: left))),
        (right) => emit(
          state.copyWith(newLoadCartStatus: CartSuccess(cartModel: right)),
        ),
      );
    });

    // add payment
    on<AddPaymentEvent>((event, emit) async {
      emit(
        state.copyWith(
          newPaymentStatus: PaymentLoading(),
          newCouponResult: null,
          setCouponResult: true,
        ),
      );

      final Either<String, Map<String, dynamic>> dataState =
          await paymentRepository.addPayment(event.cartId, event.paymentModel);

      dataState.fold(
        (left) {
          emit(state.copyWith(newPaymentStatus: PaymentError(error: left)));
        },
        (right) {
          emit(
            state.copyWith(
              newPaymentStatus: PaymentSuccess(result: right),
              newCouponResult: null,
              setCouponResult: true,
            ),
          );
        },
      );
    });
  }
}

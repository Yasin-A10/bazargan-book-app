class PaymentModel {
  final String? paymentMethod;
  final String? coupon;
  final String paymentSource;

  PaymentModel({this.paymentMethod, this.coupon, required this.paymentSource});

  Map<String, dynamic> toJson() {
    return {
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (coupon != null) 'coupon': coupon,
      'payment_source': paymentSource,
    };
  }
}

class CouponResultModel {
  final int totalFinalPrice;
  final int yourProfitAmount;
  final int yourProfitPercent;
  final int discountCodeAmount;
  final int discountCodePercent;
  final int productDiscountAmount;
  final int productDiscountPercent;
  final int totalSellPrice;

  CouponResultModel({
    required this.totalFinalPrice,
    required this.yourProfitAmount,
    required this.yourProfitPercent,
    required this.discountCodeAmount,
    required this.discountCodePercent,
    required this.productDiscountAmount,
    required this.productDiscountPercent,
    required this.totalSellPrice,
  });

  factory CouponResultModel.fromJson(Map<String, dynamic> json) {
    return CouponResultModel(
      totalFinalPrice: json['total_final_price'] ?? 0,
      yourProfitAmount: json['your_profit_amount'] ?? 0,
      yourProfitPercent: json['your_profit_percent'] ?? 0,
      discountCodeAmount: json['discount_code_amount'] ?? 0,
      discountCodePercent: json['discount_code_percent'] ?? 0,
      productDiscountAmount: json['product_discount_amount'] ?? 0,
      productDiscountPercent: json['product_discount_percent'] ?? 0,
      totalSellPrice: json['total_sell_price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_final_price': totalFinalPrice,
      'your_profit_amount': yourProfitAmount,
      'your_profit_percent': yourProfitPercent,
      'discount_code_amount': discountCodeAmount,
      'discount_code_percent': discountCodePercent,
      'product_discount_amount': productDiscountAmount,
      'product_discount_percent': productDiscountPercent,
      'total_sell_price': totalSellPrice,
    };
  }
}

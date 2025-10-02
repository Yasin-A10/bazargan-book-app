class UserTransactionModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Payment> results;

  UserTransactionModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory UserTransactionModel.fromJson(Map<String, dynamic> json) {
    return UserTransactionModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => Payment.fromJson(e))
          .toList(),
    );
  }
}

class Payment {
  final int id;
  final List<String> title;
  final String trackingCode;
  final String status;
  final PaymentDetail detailObject;
  final int amount;
  final String transactionCreatedAt;
  final String paymentMethod;
  final int discountPercent;
  final String type;

  Payment({
    required this.id,
    required this.title,
    required this.trackingCode,
    required this.status,
    required this.detailObject,
    required this.amount,
    required this.transactionCreatedAt,
    required this.paymentMethod,
    required this.discountPercent,
    required this.type,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      title: List<String>.from(json['title']),
      trackingCode: json['tracking_code'],
      status: json['status'],
      detailObject: PaymentDetail.fromJson(json['detail_object']),
      amount: json['amount'],
      transactionCreatedAt: json['transaction_created_at'],
      paymentMethod: json['payment_method'],
      discountPercent: json['discount_percent'],
      type: json['type'],
    );
  }
}

class PaymentDetail {
  final String order;

  PaymentDetail({required this.order});

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(order: json['order']);
  }
}

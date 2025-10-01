class UserModel {
  final int id;
  final String username;
  final String? displayName;
  final bool isStaff;
  final bool isSuperuser;
  final List<dynamic> searchHistory;
  final int walletBalance;
  final Subscription subscription;
  final int commentCount;
  final int markedBooksCount;
  final int transactionsCount;
  final int favouriteCategoriesCount;
  final String cartId;
  final String role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? address;
  final String? zipCode;
  final String? nationalCode;

  UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    required this.isStaff,
    required this.isSuperuser,
    required this.searchHistory,
    required this.walletBalance,
    required this.subscription,
    required this.commentCount,
    required this.markedBooksCount,
    required this.transactionsCount,
    required this.favouriteCategoriesCount,
    required this.cartId,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.zipCode,
    required this.nationalCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      displayName: json['display_name'],
      isStaff: json['is_staff'],
      isSuperuser: json['is_superuser'],
      searchHistory: json['search_history'] ?? [],
      walletBalance: json['wallet_balance'],
      subscription: Subscription.fromJson(json['subscription']),
      commentCount: json['comment_count'],
      markedBooksCount: json['marked_books_count'],
      transactionsCount: json['transactions_count'],
      favouriteCategoriesCount: json['favourite_categories_count'],
      cartId: json['cart_id'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      address: json['address'],
      zipCode: json['zip_code'],
      nationalCode: json['national_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'display_name': displayName,
      'is_staff': isStaff,
      'is_superuser': isSuperuser,
      'search_history': searchHistory,
      'wallet_balance': walletBalance,
      'subscription': subscription.toJson(),
      'comment_count': commentCount,
      'marked_books_count': markedBooksCount,
      'transactions_count': transactionsCount,
      'favourite_categories_count': favouriteCategoriesCount,
      'cart_id': cartId,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'address': address,
      'zip_code': zipCode,
      'national_code': nationalCode,
    };
  }
}

class Subscription {
  final String? name;
  final int? daysLeft;

  Subscription({required this.name, required this.daysLeft});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(name: json['name'], daysLeft: json['days_left']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'days_left': daysLeft};
  }
}

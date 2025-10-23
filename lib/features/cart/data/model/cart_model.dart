class CartModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Cart> results;

  CartModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List).map((e) => Cart.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'next': next,
    'previous': previous,
    'results': results.map((e) => e.toJson()).toList(),
  };
}

class Cart {
  final String uuid;
  final List<CartItem> cartItems;
  final int totalFinalPrice;
  final int totalSellPrice;
  final int yourProfitPercent;
  final int yourProfitAmount;

  Cart({
    required this.uuid,
    required this.cartItems,
    required this.totalFinalPrice,
    required this.totalSellPrice,
    required this.yourProfitPercent,
    required this.yourProfitAmount,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      uuid: json['uuid'],
      cartItems: (json['cart_items'] as List)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      totalFinalPrice: json['total_final_price'],
      totalSellPrice: json['total_sell_price'],
      yourProfitPercent: json['your_profit_percent'],
      yourProfitAmount: json['your_profit_amount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uuid': uuid,
    'cart_items': cartItems.map((e) => e.toJson()).toList(),
    'total_final_price': totalFinalPrice,
    'total_sell_price': totalSellPrice,
    'your_profit_percent': yourProfitPercent,
    'your_profit_amount': yourProfitAmount,
  };
}

class CartItem {
  final int id;
  final String cart;
  final Book book;
  final int finalPrice;

  CartItem({
    required this.id,
    required this.cart,
    required this.book,
    required this.finalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      cart: json['cart'],
      book: Book.fromJson(json['book']),
      finalPrice: json['final_price'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'cart': cart,
    'book': book.toJson(),
    'final_price': finalPrice,
  };
}

class Book {
  final int id;
  final String type;
  final String name;
  final String description;
  final Publisher publisher;
  final int editionYear;
  final int pageCount;
  final num? ISBN;
  final int price;
  final int priceWithDiscount;
  final bool isPurchased;
  final int discountPercent;
  final String thumbnail;
  final List<Author> author;
  final List<Author> translator;
  final List<Category> categories;
  final bool isInCart;
  final bool isMarked;
  final double? avgRate;
  final String picture;
  final String? demo;

  Book({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.publisher,
    required this.editionYear,
    required this.pageCount,
    this.ISBN,
    required this.price,
    required this.priceWithDiscount,
    required this.isPurchased,
    required this.discountPercent,
    required this.thumbnail,
    required this.author,
    required this.translator,
    required this.categories,
    required this.isInCart,
    required this.isMarked,
    required this.picture,
    this.demo,
    this.avgRate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      publisher: Publisher.fromJson(json['publisher']),
      editionYear: json['edition_year'],
      pageCount: json['page_count'],
      ISBN: json['ISBN'],
      price: json['price'],
      priceWithDiscount: json['price_with_discount'],
      isPurchased: json['is_purchased'],
      discountPercent: json['discount_percent'],
      thumbnail: json['thumbnail'],
      author: (json['author'] as List).map((e) => Author.fromJson(e)).toList(),
      translator: (json['translator'] as List)
          .map((e) => Author.fromJson(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      isInCart: json['is_in_cart'],
      isMarked: json['is_marked'],
      picture: json['picture'],
      demo: json['demo'],
      avgRate: json['avg_rate'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name': name,
    'description': description,
    'publisher': publisher.toJson(),
    'edition_year': editionYear,
    'page_count': pageCount,
    'ISBN': ISBN,
    'price': price,
    'price_with_discount': priceWithDiscount,
    'is_purchased': isPurchased,
    'discount_percent': discountPercent,
    'thumbnail': thumbnail,
    'author': author.map((e) => e.toJson()).toList(),
    'translator': translator.map((e) => e.toJson()).toList(),
    'categories': categories.map((e) => e.toJson()).toList(),
    'is_in_cart': isInCart,
    'is_marked': isMarked,
    'picture': picture,
    'demo': demo,
    'avg_rate': avgRate,
  };
}

class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Publisher {
  final int id;
  final String name;

  Publisher({required this.id, required this.name});

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Category {
  final int id;
  final String title;
  final String? icon;
  final bool isFavourite;
  final String status;

  Category({
    required this.id,
    required this.title,
    this.icon,
    required this.isFavourite,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      icon: json['icon'],
      isFavourite: json['is_favourite'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'icon': icon,
    'is_favourite': isFavourite,
    'status': status,
  };
}

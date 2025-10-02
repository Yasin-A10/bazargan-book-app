class MarkedBooksModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Book> results;

  MarkedBooksModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory MarkedBooksModel.fromJson(Map<String, dynamic> json) {
    return MarkedBooksModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List).map((e) => Book.fromJson(e)).toList(),
    );
  }
}

class Book {
  final int id;
  final String type;
  final String name;
  final String description;
  final Publisher publisher;
  final int editionYear;
  final int pageCount;
  final int? isbn;
  final int price;
  final int priceWithDiscount;
  final String? slug;
  final bool isPurchased;
  final int discountPercent;
  final String thumbnail;
  final List<Author> author;
  final dynamic narrator;
  final int? childBookId;
  final dynamic indexes;
  final List<dynamic> translator;
  final List<Category> categories;
  final dynamic awards;
  final int? rateCount; // nullable
  final double? avgRate; // nullable
  final bool isInCart;
  final int? commentsCount;
  final dynamic faqs;
  final String picture;
  final bool isMarked;
  final dynamic relatedBook;
  final bool isInInfinity;
  final String demo;

  Book({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.publisher,
    required this.editionYear,
    required this.pageCount,
    this.isbn,
    required this.price,
    required this.priceWithDiscount,
    this.slug,
    required this.isPurchased,
    required this.discountPercent,
    required this.thumbnail,
    required this.author,
    this.narrator,
    this.childBookId,
    this.indexes,
    required this.translator,
    required this.categories,
    this.awards,
    this.rateCount,
    this.avgRate,
    required this.isInCart,
    this.commentsCount,
    this.faqs,
    required this.picture,
    required this.isMarked,
    this.relatedBook,
    required this.isInInfinity,
    required this.demo,
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
      isbn: json['ISBN'],
      price: json['price'],
      priceWithDiscount: json['price_with_discount'],
      slug: json['slug'],
      isPurchased: json['is_purchased'],
      discountPercent: json['discount_percent'],
      thumbnail: json['thumbnail'],
      author: (json['author'] as List).map((e) => Author.fromJson(e)).toList(),
      narrator: json['narrator'],
      childBookId: json['child_book_id'],
      indexes: json['indexes'],
      translator: json['translator'] ?? [],
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      awards: json['awards'],
      rateCount: json['rate_count'],
      avgRate: json['avg_rate'] != null
          ? (json['avg_rate'] as num).toDouble()
          : null,
      isInCart: json['is_in_cart'],
      commentsCount: json['comments_count'],
      faqs: json['FAQs'],
      picture: json['picture'],
      isMarked: json['is_marked'],
      relatedBook: json['related_book'],
      isInInfinity: json['is_in_infinity'],
      demo: json['demo'],
    );
  }
}

class Publisher {
  final int id;
  final String name;

  Publisher({required this.id, required this.name});

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(id: json['id'], name: json['name']);
  }
}

class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name']);
  }
}

class Category {
  final int id;
  final String title;
  final dynamic parent;
  final String icon;
  final bool isFavourite;
  final String status;

  Category({
    required this.id,
    required this.title,
    this.parent,
    required this.icon,
    required this.isFavourite,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      parent: json['parent'],
      icon: json['icon'],
      isFavourite: json['is_favourite'],
      status: json['status'],
    );
  }
}

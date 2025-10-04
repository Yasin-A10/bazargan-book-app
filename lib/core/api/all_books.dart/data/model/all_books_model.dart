class BookListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<BooksModel> results;

  BookListModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory BookListModel.fromJson(Map<String, dynamic> json) {
    return BookListModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => BooksModel.fromJson(e))
          .toList(),
    );
  }
}

class BooksModel {
  final int id;
  final String type;
  final String name;
  final String? description;
  final PublisherModel publisher;
  final int? editionYear;
  final int? pageCount;
  final dynamic ISBN;
  final int price;
  final int priceWithDiscount;
  final String? slug;
  final bool isPurchased;
  final int discountPercent;
  final String thumbnail;
  final List<AuthorModel> author;
  final String? narrator;
  final int? childBookId;
  final dynamic indexes;
  final List<TranslatorModel> translator;
  final List<CategoryModel> categories;
  final dynamic awards;
  final int? rateCount;
  final double? avgRate;
  final bool isInCart;
  final int? commentsCount;
  final dynamic FAQs;
  final String picture;
  final bool isMarked;
  final dynamic relatedBook;
  final bool isInInfinity;
  final String? demo;

  BooksModel({
    required this.id,
    required this.type,
    required this.name,
    this.description,
    required this.publisher,
    this.editionYear,
    this.pageCount,
    this.ISBN,
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
    this.FAQs,
    required this.picture,
    required this.isMarked,
    this.relatedBook,
    required this.isInInfinity,
    this.demo,
  });

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      publisher: PublisherModel.fromJson(json['publisher']),
      editionYear: json['edition_year'],
      pageCount: json['page_count'],
      ISBN: json['ISBN'],
      price: json['price'],
      priceWithDiscount: json['price_with_discount'],
      slug: json['slug'],
      isPurchased: json['is_purchased'],
      discountPercent: json['discount_percent'],
      thumbnail: json['thumbnail'],
      author: (json['author'] as List)
          .map((e) => AuthorModel.fromJson(e))
          .toList(),
      narrator: json['narrator'],
      childBookId: json['child_book_id'],
      indexes: json['indexes'],
      translator: (json['translator'] as List)
          .map((e) => TranslatorModel.fromJson(e))
          .toList(),
      categories: (json['categories'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
      awards: json['awards'],
      rateCount: json['rate_count'],
      avgRate: json['avg_rate'] != null
          ? (json['avg_rate'] as num).toDouble()
          : null,
      isInCart: json['is_in_cart'],
      commentsCount: json['comments_count'],
      FAQs: json['FAQs'],
      picture: json['picture'],
      isMarked: json['is_marked'],
      relatedBook: json['related_book'],
      isInInfinity: json['is_in_infinity'],
      demo: json['demo'],
    );
  }
}

class PublisherModel {
  final int id;
  final String name;

  PublisherModel({required this.id, required this.name});

  factory PublisherModel.fromJson(Map<String, dynamic> json) {
    return PublisherModel(id: json['id'], name: json['name']);
  }
}

class AuthorModel {
  final int id;
  final String name;

  AuthorModel({required this.id, required this.name});

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(id: json['id'], name: json['name']);
  }
}

class TranslatorModel {
  final int? id;
  final String? name;

  TranslatorModel({this.id, this.name});

  factory TranslatorModel.fromJson(Map<String, dynamic> json) {
    return TranslatorModel(id: json['id'], name: json['name']);
  }
}

class CategoryModel {
  final int id;
  final String title;
  final int? parent;
  final String? icon;
  final bool isFavourite;
  final String? status;

  CategoryModel({
    required this.id,
    required this.title,
    this.parent,
    this.icon,
    required this.isFavourite,
    this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      parent: json['parent'],
      icon: json['icon'],
      isFavourite: json['is_favourite'],
      status: json['status'],
    );
  }
}

//! for query parameters
class AllBooksQuery {
  final String? search;
  final String? author;
  final String? publisher;
  final String? price;
  final String? categories;
  final String? type;
  final String? translator;
  final String? exclude;
  final String? narrator;
  final String? customized;
  final String? isInInfinity;
  final String? ordering;

  const AllBooksQuery({
    this.search,
    this.author,
    this.publisher,
    this.price,
    this.categories,
    this.type,
    this.translator,
    this.exclude,
    this.narrator,
    this.customized,
    this.isInInfinity,
    this.ordering,
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};

    void addIfNotNull(String key, String? value) {
      if (value != null && value.isNotEmpty) {
        params[key] = value;
      }
    }

    addIfNotNull('search', search);
    addIfNotNull('author', author);
    addIfNotNull('publisher', publisher);
    addIfNotNull('price', price);
    addIfNotNull('categories', categories);
    addIfNotNull('type', type);
    addIfNotNull('translator', translator);
    addIfNotNull('exclude', exclude);
    addIfNotNull('narrator', narrator);
    addIfNotNull('customized', customized);
    addIfNotNull('is_in_infinity', isInInfinity);
    addIfNotNull('ordering', ordering);

    return params;
  }

  AllBooksQuery copyWith({
    String? search,
    String? author,
    String? publisher,
    String? price,
    String? categories,
    String? type,
    String? translator,
    String? exclude,
    String? narrator,
    String? customized,
    String? isInInfinity,
    String? ordering,
  }) {
    return AllBooksQuery(
      search: search ?? this.search,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      price: price ?? this.price,
      categories: categories ?? this.categories,
      type: type ?? this.type,
      translator: translator ?? this.translator,
      exclude: exclude ?? this.exclude,
      narrator: narrator ?? this.narrator,
      customized: customized ?? this.customized,
      isInInfinity: isInInfinity ?? this.isInInfinity,
      ordering: ordering ?? this.ordering,
    );
  }
}

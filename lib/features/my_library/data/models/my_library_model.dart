class MyLibraryModel {
  final int count;
  final String? next;
  final String? previous;
  final List<MyBook> results;

  MyLibraryModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory MyLibraryModel.fromJson(Map<String, dynamic> json) {
    return MyLibraryModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => MyBook.fromJson(e))
          .toList(),
    );
  }
}

class MyBook {
  final int? id;
  final String? type;
  final String? name;
  final String? description;
  final Publisher? publisher;
  final int? editionYear;
  final int? pageCount;
  final String? isbn;
  final int? price;
  final int? priceWithDiscount;
  final String? slug;
  final bool? isPurchased;
  final int? discountPercent;
  final String? thumbnail;
  final List<Author>? author;
  final dynamic narrator;
  final int? childBookId;
  final dynamic indexes;
  final List<Translator>? translator;
  final List<Category>? categories;
  final dynamic awards;
  final int? rateCount;
  final double? avgRate;
  final bool? isInCart;
  final dynamic commentsCount;
  final dynamic faqs;
  final String? picture;
  final bool? isMarked;
  final dynamic relatedBook;
  final bool? isInInfinity;
  final String? demo;
  final dynamic hasCommented;

  MyBook({
    this.id,
    this.type,
    this.name,
    this.description,
    this.publisher,
    this.editionYear,
    this.pageCount,
    this.isbn,
    this.price,
    this.priceWithDiscount,
    this.slug,
    this.isPurchased,
    this.discountPercent,
    this.thumbnail,
    this.author,
    this.narrator,
    this.childBookId,
    this.indexes,
    this.translator,
    this.categories,
    this.awards,
    this.rateCount,
    this.avgRate,
    this.isInCart,
    this.commentsCount,
    this.faqs,
    this.picture,
    this.isMarked,
    this.relatedBook,
    this.isInInfinity,
    this.demo,
    this.hasCommented,
  });

  factory MyBook.fromJson(Map<String, dynamic> json) {
    return MyBook(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      description: json['description'],
      publisher: json['publisher'] != null
          ? Publisher.fromJson(json['publisher'])
          : null,
      editionYear: json['edition_year'],
      pageCount: json['page_count'],
      isbn: json['ISBN']?.toString(),
      price: json['price'],
      priceWithDiscount: json['price_with_discount'],
      slug: json['slug'],
      isPurchased: json['is_purchased'],
      discountPercent: json['discount_percent'],
      thumbnail: json['thumbnail'],
      author: json['author'] != null
          ? (json['author'] as List).map((e) => Author.fromJson(e)).toList()
          : null,
      narrator: json['narrator'],
      childBookId: json['child_book_id'],
      indexes: json['indexes'],
      translator: json['translator'] != null
          ? (json['translator'] as List)
                .map((e) => Translator.fromJson(e))
                .toList()
          : null,
      categories: json['categories'] != null
          ? (json['categories'] as List)
                .map((e) => Category.fromJson(e))
                .toList()
          : null,
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
      hasCommented: json['has_commented'] ?? false,
    );
  }
}

class Publisher {
  final int? id;
  final String? name;

  Publisher({this.id, this.name});

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(id: json['id'], name: json['name']);
  }
}

class Author {
  final int? id;
  final String? name;

  Author({this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name']);
  }
}

class Translator {
  final int? id;
  final String? name;

  Translator({this.id, this.name});

  factory Translator.fromJson(Map<String, dynamic> json) {
    return Translator(id: json['id'], name: json['name']);
  }
}

class Category {
  final int? id;
  final String? title;
  final int? parent;
  final String? icon;
  final bool? isFavourite;
  final String? status;

  Category({
    this.id,
    this.title,
    this.parent,
    this.icon,
    this.isFavourite,
    this.status,
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

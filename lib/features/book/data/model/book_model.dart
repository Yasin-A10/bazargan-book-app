class BookModel {
  final int? id;
  final String? type;
  final String? name;
  final String? description;
  final Publisher? publisher;
  final int? editionYear;
  final int? pageCount;
  final int? ISBN;
  final int? price;
  final int? priceWithDiscount;
  final String? slug;
  final bool? isPurchased;
  final int? discountPercent;
  final String? thumbnail;
  final List<Author> author;
  final dynamic narrator; // می‌تونه null باشه
  final int? childBookId;
  final List<Index> indexes;
  final List<Translator> translator;
  final List<Category> categories;
  final List<dynamic> awards;
  final int? rateCount;
  final double? avgRate;
  final bool? isInCart;
  final int? commentsCount;
  final List<dynamic> FAQs;
  final String? picture;
  final bool? isMarked;
  final dynamic relatedBook;
  final bool? isInInfinity;
  final String? demo;

  BookModel({
    this.id,
    this.type,
    this.name,
    this.description,
    this.publisher,
    this.editionYear,
    this.pageCount,
    this.ISBN,
    this.price,
    this.priceWithDiscount,
    this.slug,
    this.isPurchased,
    this.discountPercent,
    this.thumbnail,
    this.author = const [],
    this.narrator,
    this.childBookId,
    this.indexes = const [],
    this.translator = const [],
    this.categories = const [],
    this.awards = const [],
    this.rateCount,
    this.avgRate,
    this.isInCart,
    this.commentsCount,
    this.FAQs = const [],
    this.picture,
    this.isMarked,
    this.relatedBook,
    this.isInInfinity,
    this.demo,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json['id'],
    type: json['type'],
    name: json['name'],
    description: json['description'],
    publisher: json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null,
    editionYear: json['edition_year'],
    pageCount: json['page_count'],
    ISBN: json['ISBN'],
    price: json['price'],
    priceWithDiscount: json['price_with_discount'],
    slug: json['slug'],
    isPurchased: json['is_purchased'],
    discountPercent: json['discount_percent'],
    thumbnail: json['thumbnail'],
    author: json['author'] != null
        ? List<Author>.from(json['author'].map((x) => Author.fromJson(x)))
        : [],
    narrator: json['narrator'],
    childBookId: json['child_book_id'],
    indexes: json['indexes'] != null
        ? List<Index>.from(json['indexes'].map((x) => Index.fromJson(x)))
        : [],
    translator: json['translator'] != null
        ? List<Translator>.from(
            json['translator'].map((x) => Translator.fromJson(x)),
          )
        : [],
    categories: json['categories'] != null
        ? List<Category>.from(
            json['categories'].map((x) => Category.fromJson(x)),
          )
        : [],
    awards: json['awards'] ?? [],
    rateCount: json['rate_count'],
    avgRate: json['avg_rate'] != null
        ? (json['avg_rate'] as num).toDouble()
        : null,
    isInCart: json['is_in_cart'],
    commentsCount: json['comments_count'],
    FAQs: json['FAQs'] ?? [],
    picture: json['picture'],
    isMarked: json['is_marked'],
    relatedBook: json['related_book'],
    isInInfinity: json['is_in_infinity'],
    demo: json['demo'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'name': name,
    'description': description,
    'publisher': publisher?.toJson(),
    'edition_year': editionYear,
    'page_count': pageCount,
    'ISBN': ISBN,
    'price': price,
    'price_with_discount': priceWithDiscount,
    'slug': slug,
    'is_purchased': isPurchased,
    'discount_percent': discountPercent,
    'thumbnail': thumbnail,
    'author': author.map((x) => x.toJson()).toList(),
    'narrator': narrator,
    'child_book_id': childBookId,
    'indexes': indexes.map((x) => x.toJson()).toList(),
    'translator': translator.map((x) => x.toJson()).toList(),
    'categories': categories.map((x) => x.toJson()).toList(),
    'awards': awards,
    'rate_count': rateCount,
    'avg_rate': avgRate,
    'is_in_cart': isInCart,
    'comments_count': commentsCount,
    'FAQs': FAQs,
    'picture': picture,
    'is_marked': isMarked,
    'related_book': relatedBook,
    'is_in_infinity': isInInfinity,
    'demo': demo,
  };
}

class Publisher {
  final int? id;
  final String? name;

  Publisher({this.id, this.name});

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      Publisher(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Author {
  final int? id;
  final String? name;

  Author({this.id, this.name});

  factory Author.fromJson(Map<String, dynamic> json) =>
      Author(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Translator {
  final int? id;
  final String? name;

  Translator({this.id, this.name});

  factory Translator.fromJson(Map<String, dynamic> json) {
    return Translator(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Index {
  final int? id;
  final String? title;

  Index({this.id, this.title});

  factory Index.fromJson(Map<String, dynamic> json) =>
      Index(id: json['id'], title: json['title']);

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}

class Category {
  final int? id;
  final String? title;
  final String? parent;
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    title: json['title'],
    parent: json['parent'],
    icon: json['icon'],
    isFavourite: json['is_favourite'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'parent': parent,
    'icon': icon,
    'is_favourite': isFavourite,
    'status': status,
  };
}

class SearchModel {
  final List<Author> authors;
  final List<Category> categories;
  final List<Book> audioBooks;
  final List<Book> eBooks;
  final List<Publisher> publishers;
  final List<Translator> translators;

  SearchModel({
    required this.authors,
    required this.categories,
    required this.audioBooks,
    required this.eBooks,
    required this.publishers,
    required this.translators,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e))
          .toList(),
      audioBooks: (json['audio_books'] as List<dynamic>)
          .map((e) => Book.fromJson(e))
          .toList(),
      eBooks: (json['e_books'] as List<dynamic>)
          .map((e) => Book.fromJson(e))
          .toList(),
      publishers: (json['publishers'] as List<dynamic>)
          .map((e) => Publisher.fromJson(e))
          .toList(),
      translators: (json['translators'] as List<dynamic>)
          .map((e) => Translator.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "authors": authors.map((e) => e.toJson()).toList(),
      "categories": categories.map((e) => e.toJson()).toList(),
      "audio_books": audioBooks.map((e) => e.toJson()).toList(),
      "e_books": eBooks.map((e) => e.toJson()).toList(),
      "publishers": publishers.map((e) => e.toJson()).toList(),
      "translators": translators.map((e) => e.toJson()).toList(),
    };
  }
}

// --- Author ---
class Author {
  final int id;
  final String name;

  Author({required this.id, required this.name});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

// --- Category ---
class Category {
  final int id;
  final String title;
  final int? parent;
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "parent": parent,
    "icon": icon,
    "is_favourite": isFavourite,
    "status": status,
  };
}

// --- Book (برای e_books و audio_books) ---
class Book {
  final int id;
  final String name;
  final String picture;

  Book({required this.id, required this.name, required this.picture});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(id: json['id'], name: json['name'], picture: json['picture']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "picture": picture};
}

// --- Publisher ---
class Publisher {
  final int id;
  final String name;

  Publisher({required this.id, required this.name});

  factory Publisher.fromJson(Map<String, dynamic> json) {
    return Publisher(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

// --- Translator ---
class Translator {
  final int id;
  final String name;

  Translator({required this.id, required this.name});

  factory Translator.fromJson(Map<String, dynamic> json) {
    return Translator(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

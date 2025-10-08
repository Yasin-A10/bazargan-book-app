class UpdateCommentModel {
  final double rate;
  final String text;
  final UpdateCommentBook book;

  UpdateCommentModel({
    required this.rate,
    required this.text,
    required this.book,
  });

  factory UpdateCommentModel.fromJson(Map<String, dynamic> json) {
    return UpdateCommentModel(
      rate: (json['rate'] ?? 0).toDouble(),
      text: json['text'] ?? '',
      book: UpdateCommentBook.fromJson(json['book']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'text': text, 'book': book.toJson()};
  }
}

class UpdateCommentBook {
  final String name;
  final dynamic picture;

  UpdateCommentBook({required this.name, required this.picture});

  factory UpdateCommentBook.fromJson(Map<String, dynamic> json) {
    return UpdateCommentBook(
      name: json['name'] ?? '',
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'picture': picture};
  }
}

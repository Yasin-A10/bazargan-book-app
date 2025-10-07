class AddCommentModel {
  final int rate;
  final String text;
  final BookCommentBookModel book;

  AddCommentModel({required this.rate, required this.text, required this.book});

  Map<String, dynamic> toJson() {
    return {'rate': rate, 'text': text, 'book': book.toJson()};
  }

  factory AddCommentModel.fromJson(Map<String, dynamic> json) {
    return AddCommentModel(
      rate: json['rate'],
      text: json['text'],
      book: BookCommentBookModel.fromJson(json['book']),
    );
  }
}

class BookCommentBookModel {
  final String name;
  final int picture;

  BookCommentBookModel({required this.name, required this.picture});

  Map<String, dynamic> toJson() {
    return {'name': name, 'picture': picture};
  }

  factory BookCommentBookModel.fromJson(Map<String, dynamic> json) {
    return BookCommentBookModel(name: json['name'], picture: json['picture']);
  }
}

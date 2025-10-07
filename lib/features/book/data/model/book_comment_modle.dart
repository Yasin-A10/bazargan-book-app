class BookCommentsModel {
  final int count;
  final bool hasCommented;
  final String? next;
  final String? previous;
  final List<BookComment> results;

  BookCommentsModel({
    required this.count,
    required this.hasCommented,
    required this.next,
    required this.previous,
    required this.results,
  });

  // factory BookCommentsModel.fromJson(Map<String, dynamic> json) {
  //   return BookCommentsModel(
  //     count: json['count'] ?? 0,
  //     hasCommented: json['has_commented'] ?? false,
  //     next: json['next'],
  //     previous: json['previous'],
  //     results:
  //         (json['results'] as List<dynamic>?)
  //             ?.map((item) => BookComment.fromJson(item))
  //             .toList() ??
  //         [],
  //   );
  // }

  factory BookCommentsModel.fromJson(Map<String, dynamic> json) {
    final dynamic hasCommentedValue = json['has_commented'];

    bool parsedHasCommented;
    if (hasCommentedValue is bool) {
      parsedHasCommented = hasCommentedValue;
    } else if (hasCommentedValue is num) {
      parsedHasCommented = hasCommentedValue > 0;
    } else {
      parsedHasCommented = false;
    }

    return BookCommentsModel(
      count: json['count'] ?? 0,
      hasCommented: parsedHasCommented,
      next: json['next'],
      previous: json['previous'],
      results:
          (json['results'] as List<dynamic>?)
              ?.map((item) => BookComment.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class BookComment {
  final int id;
  final String text;
  final CommentUser user;
  final String createdAt;
  final CommentFeedback feedback;
  final CommentBook book;
  final double rate;

  BookComment({
    required this.id,
    required this.text,
    required this.user,
    required this.createdAt,
    required this.feedback,
    required this.book,
    required this.rate,
  });

  factory BookComment.fromJson(Map<String, dynamic> json) {
    return BookComment(
      id: json['id'],
      text: json['text'] ?? '',
      user: CommentUser.fromJson(json['user']),
      createdAt: json['created_at'] ?? '',
      feedback: CommentFeedback.fromJson(json['feedback']),
      book: CommentBook.fromJson(json['book']),
      rate: (json['rate'] is int)
          ? (json['rate'] as int).toDouble()
          : (json['rate'] ?? 0.0),
    );
  }
}

class CommentUser {
  final int id;
  final String? displayName;

  CommentUser({required this.id, required this.displayName});

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(id: json['id'], displayName: json['display_name']);
  }
}

class CommentFeedback {
  final int likeCount;
  final int dislikeCount;
  final bool hasLiked;
  final bool hasDisliked;

  CommentFeedback({
    required this.likeCount,
    required this.dislikeCount,
    required this.hasLiked,
    required this.hasDisliked,
  });

  factory CommentFeedback.fromJson(Map<String, dynamic> json) {
    return CommentFeedback(
      likeCount: json['like_count'] ?? 0,
      dislikeCount: json['dislike_count'] ?? 0,
      hasLiked: json['has_liked'] ?? false,
      hasDisliked: json['has_disliked'] ?? false,
    );
  }
}

class CommentBook {
  final int id;
  final String name;
  final String picture;

  CommentBook({required this.id, required this.name, required this.picture});

  factory CommentBook.fromJson(Map<String, dynamic> json) {
    return CommentBook(
      id: json['id'],
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
    );
  }
}

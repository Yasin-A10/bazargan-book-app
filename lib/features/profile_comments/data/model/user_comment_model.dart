class UserCommentModel {
  final int count;
  final String? next;
  final String? previous;
  final List<UserCommentResult> results;

  UserCommentModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory UserCommentModel.fromJson(Map<String, dynamic> json) {
    return UserCommentModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => UserCommentResult.fromJson(e))
          .toList(),
    );
  }
}

class UserCommentResult {
  final int id;
  final String text;
  final UserCommentUser user;
  final String createdAt;
  final UserCommentFeedback feedback;
  final UserCommentBook book;
  final double avgRate;
  final double rate;

  UserCommentResult({
    required this.id,
    required this.text,
    required this.user,
    required this.createdAt,
    required this.feedback,
    required this.book,
    required this.avgRate,
    required this.rate,
  });

  factory UserCommentResult.fromJson(Map<String, dynamic> json) {
    return UserCommentResult(
      id: json['id'],
      text: json['text'] ?? '',
      user: UserCommentUser.fromJson(json['user']),
      createdAt: json['created_at'] ?? '',
      feedback: UserCommentFeedback.fromJson(json['feedback']),
      book: UserCommentBook.fromJson(json['book']),
      avgRate: (json['avg_rate'] ?? 0).toDouble(),
      rate: (json['rate'] ?? 0).toDouble(),
    );
  }
}

class UserCommentUser {
  final int id;
  final String displayName;

  UserCommentUser({required this.id, required this.displayName});

  factory UserCommentUser.fromJson(Map<String, dynamic> json) {
    return UserCommentUser(
      id: json['id'],
      displayName: json['display_name'] ?? '',
    );
  }
}

class UserCommentFeedback {
  final int likeCount;
  final int dislikeCount;
  final bool hasLiked;
  final bool hasDisliked;

  UserCommentFeedback({
    required this.likeCount,
    required this.dislikeCount,
    required this.hasLiked,
    required this.hasDisliked,
  });

  factory UserCommentFeedback.fromJson(Map<String, dynamic> json) {
    return UserCommentFeedback(
      likeCount: json['like_count'] ?? 0,
      dislikeCount: json['dislike_count'] ?? 0,
      hasLiked: json['has_liked'] ?? false,
      hasDisliked: json['has_disliked'] ?? false,
    );
  }
}

class UserCommentBook {
  final int id;
  final String name;
  final String picture;

  UserCommentBook({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory UserCommentBook.fromJson(Map<String, dynamic> json) {
    return UserCommentBook(
      id: json['id'],
      name: json['name'] ?? '',
      picture: json['picture'] ?? '',
    );
  }
}

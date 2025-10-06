class FeedbackModel {
  final String type;
  final int comment;

  FeedbackModel({required this.type, required this.comment});

  Map<String, dynamic> toJson() {
    return {'type': type, 'comment': comment};
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(type: json['type'], comment: json['comment']);
  }
}

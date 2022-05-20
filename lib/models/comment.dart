import 'package:food_shop/models/user.dart';

class Comment {
  final User user;
  final String comments, id;
  final DateTime? datePost;
  final double stars;

  const Comment(
    this.id, {
    required this.user,
    required this.comments,
    required this.datePost,
    this.stars = 0.0,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['_id'] ?? json['id'],
      user: User.fromJson(json['user']),
      comments: json['comment'],
      datePost: DateTime.tryParse('${json['dataPost']}') ?? DateTime.now(),
      stars: double.tryParse('${json['stars']}') ?? 0.0,
    );
  }
}

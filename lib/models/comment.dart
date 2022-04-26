import 'dart:math';

import 'package:faker/faker.dart';
import 'package:food_shop/models/user.dart';

class Comment {
  final User user;
  final String comment;
  final DateTime? datePost;
  final double stars;

  const Comment({
    required this.user,
    required this.comment,
    required this.datePost,
    this.stars = 0.0,
  });

  factory Comment.faker() {
    final faker = Faker();
    final random = Random();

    final comment = faker.lorem
        .sentences(faker.randomGenerator.integer(3, min: 1))
        .join('. ');
    final datePost = faker.date.dateTime(minYear: 2000, maxYear: 2022);
    final stars = random.nextDouble() * 3 + 2;
    return Comment(
      comment: comment,
      datePost: datePost,
      stars: stars,
      user: User.faker(),
    );
  }
}

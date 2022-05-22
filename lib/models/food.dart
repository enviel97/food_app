import 'package:food_shop/helpers/functions.dart';
import 'package:food_shop/models/comment.dart';

enum FoodStatus { empty, normal, little }

extension _FoodStatusX on FoodStatus {
  static get enumToMap =>
      {for (FoodStatus value in FoodStatus.values) value.name: value};
}

class Food {
  final String name, description, id;
  final List<Comment> comments;
  final double finalRate, price;
  final List<String> images;
  final FoodStatus status;
  final int timePrepare;

  const Food(
    this.id, {
    required this.name,
    required this.images,
    required this.comments,
    required this.finalRate,
    required this.timePrepare,
    required this.status,
    required this.description,
    required this.price,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      '${json['id'] ?? json['_id']}',
      name: json['name'],
      images: List.from(json['imgs']),
      comments: mapToList(json['comments'], Comment.fromJson),
      finalRate: (json['finalRate'] as int).toDouble(),
      timePrepare: json['timePrepare'],
      status: _FoodStatusX.enumToMap[json['status']],
      description: json['description'],
      price: (json['price'] as int).toDouble(),
    );
  }
}

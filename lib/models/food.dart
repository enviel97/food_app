import 'package:faker/faker.dart';
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
    final faker = Food.faker();
    return Food(
      '${json['id'] ?? json['_id']}',
      name: json['name'],
      images: List.from(json['imgs']),
      comments: faker.comments,
      finalRate: (json['finalRate'] as int).toDouble(),
      timePrepare: json['timePrepare'],
      status: _FoodStatusX.enumToMap[json['status']],
      description: json['description'],
      price: (json['price'] as int).toDouble(),
    );
  }

  factory Food.faker() {
    final faker = Faker();

    final food = faker.food.dish();

    final images = List<String>.generate(
      faker.randomGenerator.integer(5, min: 3),
      (index) => faker.image.image(
        keywords: ['food', 'foods', 'culinary', food],
        random: true,
      ),
    );

    final comments = List<Comment>.generate(
      faker.randomGenerator.integer(5, min: 3),
      (index) => Comment.faker(),
    );
    final finalRate = comments.fold<double>(0.0, (sum, comt) {
      return sum + comt.stars / comments.length;
    });

    final timePrepaire = faker.randomGenerator.element([15, 20, 30, 45, 60]);

    final status = faker.randomGenerator
        .element([FoodStatus.normal, FoodStatus.little, FoodStatus.empty]);

    return Food(
      faker.randomGenerator.fromPatternToHex(['##########']),
      name: food,
      images: images,
      comments: comments,
      finalRate: finalRate,
      timePrepare: timePrepaire,
      status: status,
      description: faker.lorem
          .sentences(faker.randomGenerator.integer(20, min: 10))
          .join(' '),
      price: double.tryParse(faker.randomGenerator.fromPattern(['##.##'])) ??
          99.99,
    );
  }
}

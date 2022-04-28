import 'package:faker/faker.dart';
import 'package:food_shop/models/comment.dart';

enum FoodStatus { empty, normal, little }

class Food {
  final String name, banner, shortDecription, description;
  final List<Comment> comments;
  final double finalRate, price;
  final List<String> images;
  final FoodStatus status;
  final int timePrepare;

  const Food({
    required this.name,
    required this.images,
    required this.banner,
    required this.comments,
    required this.finalRate,
    required this.timePrepare,
    required this.status,
    required this.shortDecription,
    required this.description,
    required this.price,
  });

  factory Food.faker() {
    final faker = Faker();

    final food = faker.food;
    final banner = faker.image.image(
      width: 336,
      height: 280,
      keywords: ['food', 'foods', 'culinary'],
      random: true,
    );
    final images = List<String>.generate(
      faker.randomGenerator.integer(5, min: 3),
      (index) => faker.image.image(
        keywords: ['food', 'foods', 'culinary'],
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
      name: food.dish(),
      images: images,
      banner: banner,
      comments: comments,
      finalRate: finalRate,
      timePrepare: timePrepaire,
      status: status,
      description: food.random.string(20, min: 5),
      shortDecription: faker.lorem
          .sentences(faker.randomGenerator.integer(10, min: 2))
          .join('. '),
      price: double.tryParse(faker.randomGenerator.fromPattern(['##.##'])) ??
          99.99,
    );
  }
}

import 'package:faker/faker.dart';

enum Gender {
  male,
  female,
}

class User {
  final String displayName;
  final Gender gender;

  const User({
    required this.displayName,
    this.gender = Gender.female,
  });

  factory User.faker() {
    final faker = Faker();
    final name = faker.randomGenerator.boolean()
        ? faker.person.name()
        : faker.internet.userName();
    final gender =
        faker.randomGenerator.boolean() ? Gender.male : Gender.female;
    return User(displayName: name, gender: gender);
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';

enum Gender {
  male,
  female,
  private,
}

extension _GenderX on Gender {
  static get enumToMap =>
      {for (Gender value in Gender.values) value.name: value};
}

class User {
  final String name, email, id, avatar;
  final DateTime birth, updatedAt;
  final Gender gender;

  const User(
    this.id, {
    required this.email,
    required this.name,
    required this.avatar,
    required this.birth,
    required this.updatedAt,
    this.gender = Gender.private,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['_id'] ?? json['id'],
      avatar: json['avatar'] ?? '',
      name: json['name'],
      email: json['email'] ?? '',
      birth: DateTime.tryParse('${json['birth']}') ?? DateTime.now(),
      gender: _GenderX.enumToMap['${json['status']}'.toLowerCase()] ??
          Gender.private,
      updatedAt: DateTime.tryParse('${json['updatedAt']}') ?? DateTime.now(),
    );
  }

  factory User.create({
    required String email,
    required String name,
    required File? avatar,
    required DateTime birth,
    Gender gender = Gender.private,
  }) {
    return User(
      'Create',
      email: email,
      name: name,
      avatar: '',
      birth: birth,
      gender: gender,
      updatedAt: DateTime.now(),
    );
  }
}

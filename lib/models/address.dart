import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AddressType {
  home,
  company,
  other,
}

class Coordinates {
  final double longitude, latitude;

  const Coordinates(this.longitude, this.latitude);

  /// Should be install google_maps_flutter packet
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class Address {
  final AddressType type;
  final String id, userId, userName, userPhone;
  final Coordinates coordinates;

  const Address(
    this.id,
    this.userId, {
    required this.userName,
    required this.userPhone,
    required this.coordinates,
    this.type = AddressType.home,
  });

  factory Address.create({
    required String userName,
    required String userPhone,
    required double longitude,
    required double latitude,
    AddressType type = AddressType.home,
  }) {
    return Address(
      UniqueKey().toString(),
      UniqueKey().toString(),
      userName: userName,
      userPhone: userPhone,
      coordinates: Coordinates(longitude, latitude),
      type: type,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      json['_id'] ?? json['id'],
      json['userId'] ?? '',
      userName: json['userName'],
      userPhone: json['userPhone'] ?? '000-000-0000',
      coordinates: Coordinates(
        double.tryParse(json['longitude'] ?? '') ?? 0.0,
        double.tryParse(json['latitude'] ?? '') ?? 0.0,
      ),
    );
  }

  factory Address.faker() {
    final faker = Faker();
    return Address(
      UniqueKey().toString(),
      UniqueKey().toString(),
      userName: faker.internet.userName(),
      userPhone: faker.phoneNumber.us(),
      coordinates: const Coordinates(0.0, 10.0),
      type: AddressType.values[faker.randomGenerator.integer(3, min: 0)],
    );
  }
}

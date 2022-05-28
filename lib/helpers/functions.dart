import 'dart:convert';

import 'package:food_shop/helpers/constants.dart';

List<T> mapToList<T>(
    dynamic json, T Function(Map<String, dynamic> json) create) {
  if (json == null || json.isEmpty) {
    return [];
  }
  if (json is List<String>) {
    return List<T>.generate(
      json.length,
      (index) => create(jsonDecode(json[index])),
    );
  }
  final jsons = json as List;
  return List<T>.generate(jsons.length, (index) => create(jsons[index]));
}

T mapToModel<T>(dynamic json, T Function(Map<String, dynamic> json) create) {
  if (json == null || json.isEmpty || json is String) {
    return create({'id': json ?? ''});
  }
  return create(json);
}

String getImageUrl(String image) {
  if (image.isEmpty || image == 'null') {
    return '';
  }
  // TODO: faker data catch
  if (image.contains('i.pravatar.cc')) return image;

  return '${AppConstants.BASE_URL}$image';
}

String getAssetImagePath(String image) {
  return 'assets/images/$image.png';
}

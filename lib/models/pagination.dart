import '../helpers/functions.dart';

class Pagination<T> {
  final int totalSize, offset;
  final String id;
  final List<T> datas;

  Pagination(
    this.id, {
    required this.totalSize,
    required this.offset,
    required this.datas,
  });

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) =>
      Pagination(
        json['id'] ?? 'Null',
        totalSize: json['total_size'] ?? 0,
        offset: json['offset'],
        datas: mapToList<T>(json['products'], create),
      );
}

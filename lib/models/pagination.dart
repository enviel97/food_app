import '../helpers/functions.dart';

class Pagination<T> {
  final int total, offset, limit;
  final List<T> datas;

  Pagination({
    required this.limit,
    required this.total,
    required this.offset,
    required this.datas,
  });

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) create,
  ) =>
      Pagination(
        limit: json['limit'] ?? 20,
        total: json['total'] ?? 0,
        offset: json['offset'] ?? 0,
        datas: mapToList<T>(json['datas'], create),
      );
}

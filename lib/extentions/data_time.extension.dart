import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get toNormal {
    return DateFormat('MMM, dd yyyy - hh:mm a').format(this);
  }

  String get toDate {
    return DateFormat('MMM, dd  yyyy').format(this);
  }

  String withFormat({required String format}) {
    return DateFormat(format).format(this);
  }
}

import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get toNormal {
    return DateFormat('MMM, dd yyyy - hh:mm a').format(this);
  }
}

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format([String format = "dd MMM yyyy"]) {
    return DateFormat(format).format(this);
  }
}

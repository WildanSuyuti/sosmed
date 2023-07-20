import 'package:intl/intl.dart';

extension StringExt on String {
  String toTitleCase() {
    var text = trim();
    if (text.isEmpty) return text;
    if (text.length == 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ').trim();
  }

  DateTime readIsoDate() {
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.mmm');
    return dateFormat.parse(this);
  }
}

import 'package:intl/intl.dart';

extension DateUtil on DateTime {
  bool compareDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String getDateFormat(String dateFormat) {
    final DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }
}

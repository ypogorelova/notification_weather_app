import 'package:intl/intl.dart';

String getDay(final day) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
  final x = DateFormat('EEE').format(time);
  return x;
}

String getDayTime(final day) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
  String date = DateFormat("yMMMMd").format(time);
  return date;
}

String getWeekDayAndDate(final day) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
  return DateFormat("EEE d").format(time);
}

String getTime(final day) {
  DateTime dt = DateTime.parse(day).toLocal();
  return DateFormat("hh:mm aaa").format(dt);
}

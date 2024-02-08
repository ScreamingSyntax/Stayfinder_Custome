import 'package:intl/intl.dart';

DateTime calculateCheckOutDate(String checkIn, int stayMonths) {
  DateFormat format = DateFormat("yyyy-MM-dd");
  DateTime checkInDate = format.parse(checkIn);
  DateTime checkOutDate = DateTime(
      checkInDate.year, checkInDate.month + stayMonths, checkInDate.day);

  return checkOutDate;
}

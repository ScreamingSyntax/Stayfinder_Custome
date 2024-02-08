import 'package:intl/intl.dart';

int calculateDays(String checkIn, String checkOut) {
  DateFormat format = DateFormat("yyyy-MM-dd");
  DateTime checkInDate = format.parse(checkIn);
  DateTime checkOutDate = format.parse(checkOut);
  int daysStaying = checkOutDate.difference(checkInDate).inDays;
  if (daysStaying == 0) {
    return 1;
  }
  return daysStaying;
}

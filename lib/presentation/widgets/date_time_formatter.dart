import 'widgets_export.dart';
import 'package:intl/intl.dart';

Future<String> dateTimeFormatter(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
  if (pickedDate != null) {
    print(pickedDate);
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    return formattedDate;
  }
  return "";
}

import 'package:http/http.dart' as http;

import '../../constants/constant_exports.dart';
import '../data_exports.dart';

// class NotificationApiProvider {

class NotificationApiProvider {
  Future<List<NotificationModel>> getNotification(
      {required String token}) async {
    try {
      final url = "${getIp()}notification/";
      final request = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8'
      });
      print(request.body);
      return List.from(jsonDecode(request.body))
          .map((e) => NotificationModel.fromMap(e))
          .toList();
    } catch (e) {
      return [NotificationModel.withError(error: "Connection Error")];
    }
  }
}

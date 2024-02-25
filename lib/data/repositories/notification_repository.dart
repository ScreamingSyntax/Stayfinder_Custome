import '../data_exports.dart';

class NotificationRepository {
  NotificationApiProvider provider = new NotificationApiProvider();
  Future<List<NotificationModel>> getNotifications(
      {required String token}) async {
    return await provider.getNotification(token: token);
  }
}

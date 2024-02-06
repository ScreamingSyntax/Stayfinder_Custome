import 'widgets_export.dart';

ToastificationItem showPopup(
    {required BuildContext context,
    required String description,
    required String title,
    required ToastificationType type}) {
  return toastification.show(
      context: context,
      title: Text(title),
      autoCloseDuration: Duration(seconds: 3),
      dragToClose: true,
      padding: EdgeInsets.all(9),
      alignment: Alignment.topLeft,
      showProgressBar: true,
      description: Text(description),
      type: type);
}

import 'package:geolocator/geolocator.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class LocationHandler {
  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showPopup(
          context: context,
          description: 'Please enable gps on your system',
          title: "Service Disabled",
          type: ToastificationType.error);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showPopup(
          context: context,
          description:
              'Location permissions are denied, Please enable permissions manually from settings',
          title: "Permission Denied",
          type: ToastificationType.error);
      return false;
    }
    return true;
  }
}

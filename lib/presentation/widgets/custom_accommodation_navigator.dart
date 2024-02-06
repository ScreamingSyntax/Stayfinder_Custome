import '../../data/data_exports.dart';
import 'widgets_export.dart';

void NavigateToAccommodation(
    Accommodation accommodation, BuildContext context) {
  if (accommodation.type == "rent_room") {
    Navigator.pushNamed(context, "/rentalScreenView",
        arguments: {'id': accommodation.id});
  }
  if (accommodation.type == "hostel") {
    Navigator.pushNamed(context, "/hostelWithTierScreenView",
        arguments: {'id': accommodation.id});
  }
  if (accommodation.type == "hotel" && accommodation.has_tier == false) {
    Navigator.pushNamed(context, "/hotelNoTierScreenView",
        arguments: {'id': accommodation.id});
  }
  if (accommodation.type == "hotel" && accommodation.has_tier == true) {
    Navigator.pushNamed(context, "/hotelWithTierScreenView",
        arguments: {'id': accommodation.id});
  }
}

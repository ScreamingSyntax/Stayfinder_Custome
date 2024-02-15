import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../data/data_exports.dart';
import '../../logic/logic_exports.dart';
import '../screens/screens_export.dart';

void pushBookingDetails(
    {required BuildContext context, required BookModel booked}) {
  context.read<FetchParticularBookingDetailsCubit>()
    ..fetchParticularBookingDetails(
        token: context.read<UserDetailsStorageBloc>().state.user!.token!,
        accommodation: booked.room!.accommodation!,
        id: booked.id!.toString());
  // if(boo)
  String accommodationType = booked.room!.accommodation!.type!;
  var data = {"accommodation": booked.room!.accommodation, "id": booked.id};
  if (accommodationType == "rent_room") {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => RentalRoomBookingScreen(data: data)));
  }
  if (accommodationType == "hostel") {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => HostelRoomBookingHistory(data: data)));
  }
  if (accommodationType == "hotel") {
    bool has_tier = booked.room!.accommodation!.has_tier!;
    if (has_tier) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HotelWithTierBookingHistory(data: data)));
    }

    if (has_tier == false) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HotelWithoutTierHistory(data: data)));
    }
  }
}

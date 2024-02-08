import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

class CallBookingDetailsParticularAPi {
  static void fetchHotelWithTierApis(
      {required String token, required BuildContext context}) {
    context.read<FetchBookingRequestCubit>()
      ..fetchBookingRequests(
        token: token,
      );
  }
}

import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../../data/data_exports.dart';
import '../../../logic/logic_exports.dart';

class CallBookingDetailedDetailsParticularAPi {
  static void fetchHotelWithTierApis(
      {required String id,
      required Accommodation accommodation,
      required BuildContext context}) {
    context.read<FetchParticularBookingDetailsCubit>()
      ..fetchParticularBookingDetails(
          token: context.read<UserDetailsStorageBloc>().state.user!.token!,
          id: id,
          accommodation: accommodation);
  }
}

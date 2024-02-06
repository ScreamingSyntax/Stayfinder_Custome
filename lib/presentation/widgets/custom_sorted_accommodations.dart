import '../../data/data_exports.dart';
import '../../logic/logic_exports.dart';
import 'widgets_export.dart';

List<Accommodation> FetchSortedAccommodations(
    BuildContext context, List<Accommodation> accommodations, String type,
    {bool? hasTier}) {
  var state = context.read<FetchAccommodationsBloc>().state;
  if (state is FetchAccommodationSuccess) {
    accommodations = state.accommodation;
  }
  List<Accommodation> sortedAccommodations = [];
  accommodations.forEach((accommodation) {
    if (accommodation.type == type && accommodation.has_tier == hasTier) {
      sortedAccommodations.add(accommodation);
    }
  });
  return sortedAccommodations;
}

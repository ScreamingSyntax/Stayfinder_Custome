import 'package:stayfinder_customer/logic/logic_exports.dart';

import '../../../data/data_exports.dart';

part 'fetch_accommodations_event.dart';
part 'fetch_accommodations_state.dart';

class FetchAccommodationsBloc
    extends HydratedBloc<FetchAccommodationsEvent, FetchAccommodationsState> {
  FetchAccommodationsBloc() : super(FetchAccommodationsInitial()) {
    AccommodationRepository repository = new AccommodationRepository();
    on<HitFetchAccommodationsEvent>((event, emit) async {
      try {
        emit(FetchAccommodationLoading());
        List<Accommodation> accommodations =
            await repository.fetchAccommodations();
        if (accommodations.isNotEmpty && accommodations[0].hasError == true) {
          emit(FetchAccommodationError(message: accommodations[0].error!));
        } else {
          emit(FetchAccommodationSuccess(accommodation: accommodations));
        }
      } catch (e) {
        emit(FetchAccommodationError(message: "Something went wrong"));
      }
    });
  }

  @override
  FetchAccommodationsState? fromJson(Map<String, dynamic> json) {
    try {
      if (json.containsKey('accommodations')) {
        List<dynamic> jsonData = json['accommodations'];
        List<Accommodation> accommodations = jsonData
            .map((jsonItem) =>
                Accommodation.fromMap(jsonItem as Map<String, dynamic>))
            .toList();
        return FetchAccommodationSuccess(accommodation: accommodations);
      }
    } catch (e) {
      print("The exception is $e");
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchAccommodationsState state) {
    if (state is FetchAccommodationSuccess) {
      return {
        'accommodations': state.accommodation
            .map((accommodation) => accommodation.toMap())
            .toList(),
      };
    }
    return null;
  }
}

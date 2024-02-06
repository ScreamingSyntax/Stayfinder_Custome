import 'package:stayfinder_customer/data/data_exports.dart';

class AccommodationRepository {
  AccommodationApiProvider accommodationApiProvider =
      new AccommodationApiProvider();
  Future<List<Accommodation>> fetchAccommodations() async {
    return await accommodationApiProvider.getAllAccommodations();
  }

  Future<Success> fetchParticularAccommodation(int id) async {
    return await accommodationApiProvider.getParticularAccommodation(id);
  }

  Future<List<Accommodation>> searchAccommodation(String searchValue,
      {String? type, String? startingRate, String? endingRate}) async {
    if (type != null && startingRate == null) {
      return accommodationApiProvider.searchAccommodations(searchValue,
          type: type);
    }
    if (type != null && startingRate != null) {
      return accommodationApiProvider.searchAccommodations(searchValue,
          type: type, startingRate: startingRate, endingRate: endingRate);
    }
    return accommodationApiProvider.searchAccommodations(searchValue);
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:stayfinder_customer/constants/ip.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

class AccommodationApiProvider {
  Dio dio = new Dio();
  Future<List<Accommodation>> getAllAccommodations() async {
    try {
      final response =
          await http.get(Uri.parse("${getIp()}accommodation/display/"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Accommodation> accommodations = List.from(data["data"])
            .map((e) => Accommodation.fromMap(e))
            .toList();
        return accommodations;
      } else {
        return [Accommodation.withError("Failed to load Accommodations")];
      }
    } catch (e) {
      return [Accommodation.withError("Connection Error")];
    }
  }

  Future<Success> getParticularAccommodation(int id) async {
    try {
      final response = await http.get(
          Uri.parse("${getIp()}accommodation/display/accommodation/?id=$id"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return Success(success: 1, data: data);
      } else {
        return Success(success: 0, message: "Something wen't wrong");
      }
    } catch (e) {
      print(e);
      return Success(
          success: 0, message: "Please check your internet connection");
    }
  }

  Future<List<Accommodation>> searchAccommodations(String searchValue,
      {String? type, String? startingRate, String? endingRate}) async {
    try {
      print("This is search value of ${searchValue}");
      print("This is searched accommodation type of ${type}");
      print("This is searched accommodation starting rate ${startingRate}");
      print("This is searched accommodation ending rate ${endingRate}");

      final request = http.MultipartRequest(
          'POST', Uri.parse("${getIp()}accommodation/search/"));
      request.fields['search_value'] = searchValue;
      if (type != null && startingRate == null) {
        request.fields['type'] = type;
      }
      if (startingRate != null) {
        request.fields['type'] = type!;
        request.fields['starting_rate'] =
            double.tryParse(startingRate)!.round().toString();
        request.fields['ending_rate'] =
            double.tryParse(endingRate!)!.round().toString();
      }
      print(request.fields.entries);
      final response = await request.send().timeout(Duration(seconds: 10));
      final finalResponse = await http.Response.fromStream(response);
      final data = jsonDecode(finalResponse.body);

      if (response.statusCode == 200) {
        if (data['success'] == 0) {
          return [Accommodation.withError(data["message"])];
        }
        print(data);
        List<Accommodation> accommodations = List.from(data["data"])
            .map((e) => Accommodation.fromMap(e))
            .toList();
        return accommodations;
      } else {
        return [Accommodation.withError("Failed to load Accommodations")];
      }
    } on TimeoutException catch (e) {
      print('The connection has timed out, please try again');
      return [
        Accommodation.withError(
            "The connection has timed out, please try again")
      ];
    } catch (e) {
      print(e);
      return [Accommodation.withError("Internet Connection Problem")];
    }
  }
}

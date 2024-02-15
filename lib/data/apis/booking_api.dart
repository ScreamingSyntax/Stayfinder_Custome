import 'package:http/http.dart' as http;
import 'package:stayfinder_customer/presentation/widgets/widgets_export.dart';

import '../../constants/ip.dart';
import '../data_exports.dart';

class BookingApiProvider {
  Future<Success> bookingRequest(
      {required String token, required int roomId}) async {
    try {
      final url = Uri.parse("${getIp()}book/request/");
      final request = await http.post(url,
          headers: {
            "Authorization": "Token $token",
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode({"room_id": roomId}));
      final response = json.decode(request.body);
      return Success.fromMap(response);
    } catch (e) {
      return Success(success: 0, message: "Connection Error");
    }
  }

  Future<Success> directBookingRequests(
      {required String token,
      required int roomId,
      required String checkIn,
      required String checkOut,
      required int paidAmount,
      int? requestID}) async {
    try {
      final url = Uri.parse("${getIp()}book/");
      final request = http.MultipartRequest("POST", url);
      request.headers["Authorization"] = "Token $token";
      request.fields["room_id"] = roomId.toString();
      request.fields["check_in"] = checkIn;
      request.fields["check_out"] = checkOut;
      request.fields["paid_amount"] = paidAmount.toString();
      print("Request id ${requestID}");
      if (requestID != null) {
        print("nigga");
        request.fields["request_id"] = requestID.toString();
      }
      final response = await request.send();
      final finalResponse = await http.Response.fromStream(response);
      final responseData = jsonDecode(finalResponse.body);
      print("The  resposne is ${responseData}");
      return Success.fromMap(responseData);
    } catch (e) {
      return Success(
          success: 0, message: "Please check your internet connection");
    }
  }

  Future<List<BookModel>> fetchBookingHistory({required String token}) async {
    try {
      final url = "${getIp()}book/book/history/";
      final request = await http
          .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
      final body = jsonDecode(request.body);
      print(body);
      if (body['success'] == 0) {
        return [BookModel.withError(body["message"])];
      }
      print("Dadad");
      // print(body["data"]);
      if (body["data"] == []) {
        return [];
      }
      return List.from(body["data"]).map((e) => BookModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
      return [BookModel.withError("Please Check Your Internet Connection")];
    }
  }

  Future<Success> viewParicularBooking(
      {required String token, required String id}) async {
    try {
      final url = Uri.parse("${getIp()}book/details/?id=${id}");
      final request = await http.get(url, headers: {
        "Authorization": "Token ${token}",
        'Content-Type': 'application/json; charset=UTF-8',
      });
      final response = json.decode(request.body);
      print(response);
      Success success = Success.fromMap(response);
      return success;
    } catch (e) {
      return Success(success: 0, message: "Check your internet connection");
    }
  }

  Future<List<BookModel>> fetchBookingsToReview({required String token}) async {
    try {
      final url = "${getIp()}review/toReview/";
      final request = await http
          .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
      final body = jsonDecode(request.body);
      print(body);
      if (body['success'] == 0) {
        return [BookModel.withError(body["message"])];
      }
      print("Dadad");
      // print(body["data"]);
      if (body["data"] == []) {
        return [];
      }
      return List.from(body["data"]).map((e) => BookModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
      return [BookModel.withError("Please Check Your Internet Connection")];
    }
  }

  Future<List<BookingRequest>> fetchBookingRequestHistory(
      {required String token}) async {
    try {
      final url = "${getIp()}book/request/history/";
      final request = await http
          .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
      final body = jsonDecode(request.body);
      if (body['success'] == 0) {
        return [BookingRequest.withError(body["message"])];
      }

      List<BookingRequest> requestLists = List.from(body["data"])
          .map((e) => BookingRequest.fromMap(e))
          .toList();

      return requestLists;
    } catch (e) {
      print(e);
      return [
        BookingRequest.withError("Please Check Your Internet Connection")
      ];
    }
  }

  Future<Success> fetchBookRequests({required String token}) async {
    try {
      final url = Uri.parse("${getIp()}book/");
      final request = await http.get(
        url,
        headers: {
          "Authorization": "Token ${token}",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final response = json.decode(request.body);
      print(response);

      print(response.runtimeType);
      int success = response["success"];
      if (success == 1) {
        Map<String, dynamic> data = response["data"];
        return Success(success: success, data: data);
      }

      return Success(success: 0, message: response["message"]);
    } catch (e) {
      print(e);
      return Success(success: 0, message: "Check your internet connection");
    }
  }
}

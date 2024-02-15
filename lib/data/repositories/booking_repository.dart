import 'package:stayfinder_customer/data/data_exports.dart';

class BookingRepository {
  BookingApiProvider _bookingApiProvider = new BookingApiProvider();
  Future<Success> bookingRequest(
      {required String token, required int roomId}) async {
    return await _bookingApiProvider.bookingRequest(
        token: token, roomId: roomId);
  }

  Future<Success> directBookingRequests(
      {required String token,
      required int roomId,
      required String checkIn,
      required String checkOut,
      required int paidAmount,
      int? requestID}) async {
    return await _bookingApiProvider.directBookingRequests(
        requestID: requestID,
        token: token,
        roomId: roomId,
        checkIn: checkIn,
        checkOut: checkOut,
        paidAmount: paidAmount);
  }

  Future<Success> viewParticularBookingDetails(
      {required String token, required String id}) async {
    return _bookingApiProvider.viewParicularBooking(token: token, id: id);
  }

  Future<List<BookingRequest>> fetchBookingRequestHistory(
      {required String token}) async {
    return await _bookingApiProvider.fetchBookingRequestHistory(token: token);
  }

  Future<List<BookModel>> fetchBookingHistory({required String token}) async {
    return await _bookingApiProvider.fetchBookingHistory(token: token);
  }

  Future<List<BookModel>> fetchBookingsToReview({required String token}) async {
    return await _bookingApiProvider.fetchBookingsToReview(token: token);
  }

  Future<Success> fetchBookRequests({
    required String token,
  }) async {
    return await _bookingApiProvider.fetchBookRequests(token: token);
  }
}

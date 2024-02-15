import '../../logic/logic_exports.dart';
import '../data_exports.dart';

class ReviewRepository {
  ReviewApiProvider _reviewApiProvider = new ReviewApiProvider();
  Future<Success> deleteReview({required int id, required String token}) async {
    return await _reviewApiProvider.deleteReview(id: id, token: token);
  }

  Future<List<ReviewModel>> viewAccommodationReviews({required int id}) async {
    return await _reviewApiProvider.viewAccommodationReviews(id: id);
  }

  Future<List<ReviewModel>> viewGivenAccommodations(
      {required String token}) async {
    return await _reviewApiProvider.viewGivenAccommodations(token: token);
  }

  Future<Success> updateReview(
      {required int id,
      String? title,
      required String token,
      String? description,
      File? image}) async {
    return await _reviewApiProvider.updateReview(
        id: id,
        title: title,
        description: description,
        image: image,
        token: token);
  }

  Future<Success> addReview(
      {required String title,
      required String token,
      required String description,
      required int bookId,
      File? image}) async {
    return await _reviewApiProvider.addReview(
        title: title,
        token: token,
        description: description,
        bookId: bookId,
        image: image);
  }
}

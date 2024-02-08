import 'package:stayfinder_customer/constants/constant_exports.dart';
import 'package:stayfinder_customer/data/data_exports.dart';
import 'package:http/http.dart' as http;

class WishListApiProvider {
  Future<List<WishListModel>> viewWishLists({required String token}) async {
    try {
      final url = "${getIp()}book/wishlist/";
      final request = await http
          .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
      final body = jsonDecode(request.body);
      if (body['success'] == 0) {
        return [WishListModel.withError(body["message"])];
      }
      return List.from(body["data"])
          .map((e) => WishListModel.fromMap(e))
          .toList();
    } catch (e) {
      return [WishListModel.withError("Please Check Your Internet Connection")];
    }
  }

  Future<Success> addToWishList(
      {required int id, required String token}) async {
    try {
      final url = "${getIp()}book/wishlist/";
      final request = await http.post(Uri.parse(url),
          headers: {"Authorization": "Token $token"},
          body: jsonEncode({"id": id}));

      final body = jsonDecode(request.body);
      return Success.fromMap(body);
    } catch (e) {
      return Success(success: 0, message: "Please check your internet info");
    }
  }

  Future<Success> deleteFromWishList(
      {required int id, required String token}) async {
    try {
      final url = "${getIp()}book/wishlist/";
      final request = await http.delete(Uri.parse(url),
          headers: {"Authorization": "Token $token"},
          body: jsonEncode({"id": id}));
      final body = jsonDecode(request.body);
      return Success.fromMap(body);
    } catch (e) {
      return Success(success: 0, message: "Please check your internet info");
    }
  }
}

import 'package:stayfinder_customer/data/data_exports.dart';

class WishListRepository {
  WishListApiProvider _wishListApiProvider = new WishListApiProvider();
  Future<List<WishListModel>> viewWishLists({required String token}) async {
    return await _wishListApiProvider.viewWishLists(token: token);
  }

  Future<Success> addToWishList(
      {required int id, required String token}) async {
    return await _wishListApiProvider.addToWishList(id: id, token: token);
  }

  Future<Success> deleteFromWishList(
      {required int id, required String token}) async {
    return await _wishListApiProvider.deleteFromWishList(id: id, token: token);
  }
}

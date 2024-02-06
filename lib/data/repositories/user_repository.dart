import 'dart:io';

import 'package:stayfinder_customer/data/data_exports.dart';

class UserRepository {
  UserApiProvider userApiProvider = new UserApiProvider();
  Future<Success> loginUser({required String email, required String password}) {
    return userApiProvider.loginCustomer(email: email, password: password);
  }

  Future<Success> registerUser(
      {required String name,
      required String email,
      required String password,
      required File image}) {
    return userApiProvider.registerCustomer(
        name: name, email: email, password: password, image: image);
  }

  Future<Success> registerUserWithOtp(
      {required String name,
      required String email,
      required String password,
      required String otp,
      required File image}) {
    return userApiProvider.registerCustomerWithOtp(
        name: name, email: email, password: password, image: image, otp: otp);
  }
}

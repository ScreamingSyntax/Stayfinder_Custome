import 'dart:io';

import 'package:flutter/rendering.dart';
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

  Future<Success> resetPassword(
      {required String token,
      required String oldPass,
      required String newPass}) async {
    return await userApiProvider.resetPassword(
        oldPass: oldPass, newPass: newPass, token: token);
  }

  Future<Success> forgotPassword(
      {required String email, String? newPassword, String? otp}) async {
    return await userApiProvider.forgotPassword(
        email: email, newPassword: newPassword, otp: otp);
  }
}

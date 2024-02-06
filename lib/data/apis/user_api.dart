import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:stayfinder_customer/constants/constant_exports.dart';
import 'package:stayfinder_customer/data/models/success_model.dart';

class UserApiProvider {
  Dio dio = new Dio();
  Future<Success> registerCustomer(
      {required String name,
      required String email,
      required String password,
      required File image}) async {
    try {
      final url = "${getIp()}customer/";
      final request = await http.MultipartRequest('POST', Uri.parse(url));
      request.fields['full_name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.files.add(http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
      final response = await request.send();
      final finalResponse = await http.Response.fromStream(response);

      final responseData = jsonDecode(finalResponse.body);
      return Success.fromMap(responseData);
    } catch (Exception) {
      return Success(success: 0, message: "Network Error");
    }
  }

  Future<Success> registerCustomerWithOtp(
      {required String name,
      required String email,
      required String password,
      required File image,
      required String otp}) async {
    try {
      final url = "${getIp()}customer/";
      final request = await http.MultipartRequest('POST', Uri.parse(url));
      request.fields['full_name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['otp'] = otp;
      request.files.add(http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: 'accommodation_image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));
      final response = await request.send();
      final finalResponse = await http.Response.fromStream(response);

      final responseData = jsonDecode(finalResponse.body);
      return Success.fromMap(responseData);
    } catch (Exception) {
      return Success(success: 0, message: "Network Error");
    }
  }

  Future<Success> loginCustomer(
      {required String email, required String password}) async {
    try {
      final url = "${getIp()}customer/";
      final request =
          await dio.get(url, data: {'email': email, 'password': password});
      print(request.data['data'].runtimeType);
      Success success = Success.fromMap(request.data);
      if (success.success == 1) {
        success.data = request.data['data'];
      }
      return success;
    } catch (Exception) {
      return Success(success: 0, message: "Network Error");
    }
  }
}

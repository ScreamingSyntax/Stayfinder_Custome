import 'package:stayfinder_customer/constants/constant_exports.dart';
import 'package:stayfinder_customer/data/models/review_model.dart';
import 'package:stayfinder_customer/logic/logic_exports.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ReviewApiProvider {
  Future<List<ReviewModel>> viewAccommodationReviews({required int id}) async {
    try {
      final url = "${getIp()}review/?id=${id}";
      final request = await http.get(Uri.parse(url));
      final body = jsonDecode(request.body);
      // return await List.from(÷)
      int success = body['success'];
      if (success == 0) {
        return [ReviewModel.withError(body['message'])];
      }
      return await List.from(body["data"])
          .map((e) => ReviewModel.fromMap(e))
          .toList();
    } catch (e) {
      return [ReviewModel.withError("Connection Error")];
    }
  }

  Future<List<ReviewModel>> viewGivenAccommodations(
      {required String token}) async {
    try {
      final url = "${getIp()}review/customer/";
      final request = await http.get(Uri.parse(url));
      final body = jsonDecode(request.body);
      // return await LisAt.from(÷)
      int success = body['success'];
      if (success == 0) {
        return [ReviewModel.withError(body['message'])];
      }
      return await List.from(body["data"])
          .map((e) => ReviewModel.fromMap(e))
          .toList();
    } catch (e) {
      return [ReviewModel.withError("Connection Error")];
    }
  }

  Future<Success> deleteReview({required int id, required String token}) async {
    try {
      final url = "${getIp()}review/";
      final request = await http.delete(Uri.parse(url),
          headers: {'Authorization': 'Token $token'},
          body: jsonEncode({'id': id}));
      final body = jsonDecode(request.body);
      return await Success.fromMap(body);
    } catch (e) {
      return Success(
          success: 0, message: "Please check your internet connection");
    }
  }

  Future<Success> updateReview(
      {required int id,
      String? title,
      required String token,
      String? description,
      File? image}) async {
    try {
      final url = "${getIp()}review/";
      final request = await http.MultipartRequest('PATCH', Uri.parse(url));
      Map fields = {
        'title': title,
        'description': description,
      };
      request.fields['id'] = id.toString();
      fields.forEach((key, value) {
        if (value != null) {
          request.fields[key] = value.toString();
        }
      });
      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'review_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      }
      final response = await request.send();
      final finalResponse = await http.Response.fromStream(response);
      final responseData = jsonDecode(finalResponse.body);
      return Success.fromMap(responseData);
    } catch (Exception) {
      return Success(success: 0, message: "Network Error");
    }
  }

  Future<Success> addReview(
      {required String title,
      required String token,
      required String description,
      required int accommodation,
      File? image}) async {
    try {
      final url = "${getIp()}review/";
      final request = await http.MultipartRequest('POST', Uri.parse(url));
      request.fields['title'] = title;
      request.headers['Authorization'] = "Token $token";
      request.fields['description'] = description;
      request.fields['accommodation'] = accommodation.toString();
      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: 'review_image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));
      }
      final response = await request.send();
      final finalResponse = await http.Response.fromStream(response);
      final responseData = jsonDecode(finalResponse.body);
      return Success.fromMap(responseData);
    } catch (Exception) {
      return Success(success: 0, message: "Network Error");
    }
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth_project/app/core/models/api_response_model.dart';
import 'package:firebase_auth_project/app/core/services/enum_api_method_type.dart';
import 'package:http/http.dart' as http;

class ApiController {
  Future<ApiResponseModel> callAPi(
      {required ApiMethodTypeEnum apiMethodTypeEnum,
      required String url,
      Map<String, String> params = const {},
      required Map<String, String> headers}) async {
    final http.Response response;

    try {
      switch (apiMethodTypeEnum) {
        case ApiMethodTypeEnum.get:
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case ApiMethodTypeEnum.post:
          response =
              await http.post(Uri.parse(url), headers: headers, body: params);
          break;
        case ApiMethodTypeEnum.put:
          response =
              await http.put(Uri.parse(url), headers: headers, body: params);
          break;
        case ApiMethodTypeEnum.delete:
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
      }
      return ApiResponseModel.fromResponse(
          jsonDecode(response.body) as Map<String, dynamic>);
    } catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    }
  }
}

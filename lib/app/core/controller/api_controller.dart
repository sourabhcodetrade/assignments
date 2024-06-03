import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
    log("Api Called");
    log("Request type: ${apiMethodTypeEnum.toString()}");
    log("url: $url");
    log("headers: $headers");
    log("params: $params");

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

      final String prettyJsonString = const JsonEncoder.withIndent('   ')
          .convert(jsonDecode(response.body));
      log("Response : ");
      log(prettyJsonString);
      return ApiResponseModel.fromResponse(jsonDecode(response.body));
    } on SocketException catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    } on http.ClientException catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    } on TimeoutException catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    } catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    }
  }
}

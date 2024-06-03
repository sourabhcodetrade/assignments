import 'dart:convert';
import 'dart:developer';

import '../models/api_response_model.dart';
import '../services/enum_api_method_type.dart';
import 'package:dio/dio.dart';

class ApiControllerDio {
  final Dio dio = Dio();


  
  Future<ApiResponseModel> callAPi(
      {required ApiMethodTypeEnum apiMethodTypeEnum,
      required String url,
      Map<String, String> params = const {},
      required Map<String, String> headers}) async {
    final Response response;
    log("Api Called");
    log("Request type: ${apiMethodTypeEnum.toString()}");
    log("url: $url");
    log("headers: $headers");
    log("params: $params");
    try {
      switch (apiMethodTypeEnum) {
        case ApiMethodTypeEnum.get:
          response = await dio.get(url,
              data: params,
              options: Options(
                headers: headers,
              ));
          break;
        case ApiMethodTypeEnum.post:
          response = await dio.post(url,
              data: params,
              options: Options(
                headers: headers,
              ));
          break;
        case ApiMethodTypeEnum.put:
          response = await dio.put(url,
              options: Options(headers: headers, extra: params));
          break;
        case ApiMethodTypeEnum.delete:
          response = await dio.delete(url, options: Options(headers: headers));
          break;
      }
      final decodedResponseData = jsonDecode(response.data);
      log("response: ");
      log("  success: ${decodedResponseData["result"]["success"]}");
      log("  result: ${decodedResponseData["result"]["result"]}");
      log("  message: ${decodedResponseData["result"]["message"]}");
      return ApiResponseModel.fromResponse(decodedResponseData);
    } catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    }
  }
}

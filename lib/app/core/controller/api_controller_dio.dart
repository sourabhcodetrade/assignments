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
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        log("Api Called");
        log('Method: ${options.method}');
        log('Request path:  ${options.path}');
        log('Parameter: ${options.method == 'GET' ? options.queryParameters : options.data}');
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        log('Response Status code: ${response.statusCode}');
        final String getPrettyJSONString =
            const JsonEncoder.withIndent(" ").convert(response.data);
        log("Response : ");
        log(getPrettyJSONString);
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        log('Error: ${error.message}');
        return handler.next(error);
      },
    ));
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
      return ApiResponseModel.fromResponse(jsonDecode(response.data));
    } catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    }
  }
}

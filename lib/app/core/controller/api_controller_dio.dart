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
        final String prettyJsonString = const JsonEncoder.withIndent('   ')
            .convert(jsonDecode(response.data));
        log("Response : ");
        log(prettyJsonString);
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
    } on DioException catch (e) {
      final errorMsg = handleDioError(e);
      return ApiResponseModel(success: false, result: "", message: errorMsg);
    } catch (e) {
      return ApiResponseModel(
          success: false, result: "", message: e.toString());
    }
  }
  String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection Timeout";
      case DioExceptionType.sendTimeout:
        return "Timeout occurred while sending";
      case DioExceptionType.receiveTimeout:
        return "Timeout occurred while receiving";
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return "Bad Request";
            case 401:
            case 403:
              return "Unauthorized";
            case 429:
              return "Too Many Requests";
            case 500:
              return "Internal Server Error";
          }
        }
        break;
      case DioExceptionType.cancel:
        return "Something went wrong";
      case DioExceptionType.unknown:
        return "No Internet Connection";
      case DioExceptionType.badCertificate:
        return "Internal Server Error";
      case DioExceptionType.connectionError:
        return "Connection Error";
      default:
        return "Unknown Error";
    }
    return "Unknown Error";
  }
}

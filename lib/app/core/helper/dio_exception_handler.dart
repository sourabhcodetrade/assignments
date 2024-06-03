import 'package:dio/dio.dart';

class DioExceptionHandler{

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
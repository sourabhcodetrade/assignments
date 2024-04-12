import 'package:dio/dio.dart';
import 'package:http_dio/modules/auth/controller/sotrage/store.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await Store.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['content-type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
     
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {}
}

import 'package:dio/dio.dart';
import 'package:http_dio/modules/auth/controller/Interceptor/dio_interceptor.dart';
import 'package:http_dio/modules/auth/controller/sotrage/store.dart';

class MyAPI {
  late final Dio _dio;

  MyAPI() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _loginUrl =
      'http://restapi.adequateshop.com/api/authaccount/login';
  final String _dataUrl = 'https://restapi.adequateshop.com/api/user?page=1';

  Map<String, dynamic> get _loginData =>
      {"email": "Developer5@gmail.com", "password": "123456"};

  Future<void> _saveToken(Map<String, dynamic> data) async {
    final token = data['data']['Token'];
    await Store.setToken(token);
  }

  String _getResult(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'];

    return "Recieved ${list.length} obj";
  }

  Future<bool> dioLogin() async {
    final response = await _dio.post(_loginUrl, data: _loginData);
    if (response.statusCode == 200) {
     await _saveToken(response.data);
      return true;
    }
    return false;
  }

  Future<String> dioGetData() async {
    try {
      final response = await _dio.post(_dataUrl);

      if (response.statusCode == 200) {
        return _getResult(response.data);
      }
      return response.data.toString();
    } on DioException catch (e) {
      return e.response?.data ?? 'Error Occured';
    }
  }
}

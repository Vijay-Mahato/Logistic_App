import 'package:dio/dio.dart';

import '../components/constants_empty.dart';

class Api {
  static final Dio _dio = Dio(); // Create a static Dio instance

  static Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters,
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ));
      return response;
    } catch (e) {
      // Handle errors here
      throw e;
    }
  }


  static Future<Response> post(String url, {dynamic data}) async {
    try {
      print("URL: $url");
      final response = await _dio.post(url, data: data ,options: Options(
        headers: {'Authorization': 'Bearer $accessToken'},
      ));
      return response;
    } catch (e) {
      // Handle errors here
      print(e);
      throw e;
    }
  }
}
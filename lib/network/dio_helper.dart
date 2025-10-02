import 'package:dio/dio.dart';
import 'package:nasa_project/network/end_point.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(baseUrl: baseUrl, receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String end_point,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio.get(end_point, queryParameters: query);
  }
}

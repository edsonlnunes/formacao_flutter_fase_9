import 'package:dio/dio.dart';

abstract class AppConstants {
  static const String baseUrl =
      'https://9512-2804-4508-511a-9081-447d-616f-ea1b-5e25.ngrok-free.app/api';
  static String? token;
  static Map<String, String> get headerApi => {
        'authorization': 'Bearer $token',
      };
  static final dioOptions = Options(headers: AppConstants.headerApi);
}

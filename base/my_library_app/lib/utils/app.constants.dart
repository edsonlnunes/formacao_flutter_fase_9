import 'package:dio/dio.dart';

abstract class AppConstants {
  static const String baseUrl =
      'https://6155-2804-4508-511d-79c1-5c2-4112-17ef-8dfc.ngrok-free.app/api';
  static String? token;
  static Map<String, String> get headerApi => {
        'authorization': 'Bearer $token',
      };
  static final dioOptions = Options(headers: AppConstants.headerApi);
}

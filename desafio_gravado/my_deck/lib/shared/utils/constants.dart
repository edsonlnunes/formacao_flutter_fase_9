import 'package:dio/dio.dart';

class Constants {
  static String userToken = '';
  static String baseUrl =
      'https://15e1-2804-4508-511a-9081-519c-31cc-6352-5342.ngrok-free.app/api';

  static Options get dioOptions => Options(
        headers: {
          'authorization': 'Bearer $userToken',
        },
      );
}

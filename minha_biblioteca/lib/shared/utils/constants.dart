import 'package:dio/dio.dart';

class Constants {
  static String baseApiUrl =
      'https://0a9c-2804-4508-511a-9081-2438-9692-91a3-63cc.ngrok-free.app/api';
  static String userToken = '';
  static Options get dioOptions => Options(
        headers: {'Authorization': 'Bearer $userToken'},
      );
}

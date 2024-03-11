import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';
import '../dtos/account.dto.dart';

class LoginService {
  final Dio dio;

  LoginService(this.dio);

  Future<String> call(AccountDTO dto) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/login',
      data: dto.toMap(),
    );

    return response.data;
  }
}

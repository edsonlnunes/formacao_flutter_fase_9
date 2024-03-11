import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';
import '../dtos/account.dto.dart';

class RegisterService {
  final Dio dio;

  RegisterService(this.dio);

  Future<void> call(AccountDTO dto) async {
    await dio.post('${AppConstants.baseUrl}/register', data: dto.toMap());
  }
}

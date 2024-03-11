import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';

class RemoveCategoryService {
  final Dio dio;

  RemoveCategoryService(this.dio);

  Future<void> call(int id) async {
    await dio.delete(
      '${AppConstants.baseUrl}/categories/$id',
      options: AppConstants.dioOptions,
    );
  }
}

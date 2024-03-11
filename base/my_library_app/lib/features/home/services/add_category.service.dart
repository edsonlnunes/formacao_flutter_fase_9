import 'package:dio/dio.dart';

import '../../../shared/entities/category.entity.dart' as entity;
import '../../../utils/app.constants.dart';
import '../dtos/add_category.dto.dart';

class AddCategoryService {
  final Dio dio;

  AddCategoryService(this.dio);

  Future<entity.Category> call(AddCategoryDTO dto) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/categories',
      data: dto.toMap(),
      options: AppConstants.dioOptions,
    );

    return entity.Category.fromMap(response.data);
  }
}

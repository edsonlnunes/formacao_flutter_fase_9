import 'package:dio/dio.dart';

import '../../../shared/entities/category.entity.dart';
import '../../../utils/app.constants.dart';

class GetAllCategoriesService {
  final Dio dio;

  const GetAllCategoriesService(this.dio);

  Future<List<Category>> call() async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/categories',
      options: AppConstants.dioOptions,
    );

    return List<Category>.from(
      response.data.map((e) => Category.fromMap(e)),
    );
  }
}

import 'package:dio/dio.dart';

import '../../../shared/models/category.model.dart';
import '../../../shared/models/custom_error.model.dart';
import '../../../shared/utils/constants.dart';
import '../dtos/add_category.dto.dart';

class CategoryService {
  late final Dio _dio;

  CategoryService() {
    _dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));
  }

  Future<dynamic> createCategory(AddCategoryDto dto) async {
    try {
      final response = await _dio.post(
        "/categories",
        data: dto.toMap(),
        options: Constants.dioOptions,
      );

      return Category.fromMap(response.data);
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get(
        "/categories",
        options: Constants.dioOptions,
      );

      return (response.data as List)
          .map(
            (category) => Category.fromMap(category),
          )
          .toList();
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<void> removeCategory(int idCategory) async {
    try {
      await _dio.delete(
        "/categories/$idCategory",
        options: Constants.dioOptions,
      );
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }
}

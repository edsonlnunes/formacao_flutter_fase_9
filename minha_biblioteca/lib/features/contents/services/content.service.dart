import 'package:dio/dio.dart';

import '../../../shared/models/content.model.dart';
import '../../../shared/models/custom_error.model.dart';
import '../../../shared/utils/constants.dart';
import '../dtos/add_content.dto.dart';
import '../dtos/remove_content.dto.dart';
import '../dtos/update_content.dto.dart';

class ContentService {
  late final Dio _dio;

  ContentService(Dio dio) : _dio = dio;

  Future<Content> createContent(AddContentDto dto) async {
    try {
      final response = await _dio.post(
        "/categories/${dto.categoryId}/contents",
        data: dto.toMap(),
        options: Constants.dioOptions,
      );

      return Content.fromMap(response.data);
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<List<Content>> getContents(int categoryId) async {
    try {
      final response = await _dio.get(
        "/categories/$categoryId/contents",
        options: Constants.dioOptions,
      );

      final contents = (response.data as List).map(
        (content) => Content.fromMap(content),
      );

      return contents.toList();
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<void> updateContent(UpdateContentDto dto) async {
    try {
      await _dio.put(
        "/categories/${dto.categoryId}/contents/${dto.contentId}",
        data: dto.toMap(),
        options: Constants.dioOptions,
      );
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }

  Future<void> removeContent(RemoveContentDto dto) async {
    try {
      await _dio.delete(
        "/categories/${dto.categoryId}/contents/${dto.contentId}",
        options: Constants.dioOptions,
      );
    } on DioException catch (e) {
      throw CustomError(e.response!.data['error']);
    }
  }
}

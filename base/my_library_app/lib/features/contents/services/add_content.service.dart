import 'package:dio/dio.dart';

import '../../../shared/entities/content.entity.dart';
import '../../../utils/app.constants.dart';
import '../dtos/add_content.dto.dart';

class AddContentService {
  final Dio dio;

  AddContentService(this.dio);

  Future<Content> call(AddContentDTO dto) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/categories/${dto.categoryId}/contents',
      data: dto.toMap(),
      options: AppConstants.dioOptions,
    );

    return Content.fromMap(response.data);
  }
}

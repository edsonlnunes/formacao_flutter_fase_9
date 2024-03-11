import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';
import '../dtos/update_content.dto.dart';

class UpdateContentService {
  final Dio dio;

  UpdateContentService(this.dio);

  Future<void> call(UpdateContentDTO dto) async {
    await dio.put(
      '${AppConstants.baseUrl}/categories/${dto.categoryId}/contents/${dto.id}',
      data: dto.toMap(),
      options: AppConstants.dioOptions,
    );
  }
}

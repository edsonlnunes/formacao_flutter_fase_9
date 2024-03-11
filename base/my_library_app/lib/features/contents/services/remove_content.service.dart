import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';
import '../dtos/remove_content.dto.dart';

class RemoveContentService {
  final Dio dio;

  RemoveContentService(this.dio);

  Future<void> call(RemoveContentDTO dto) async {
    await dio.delete(
      '${AppConstants.baseUrl}/categories/${dto.categoryId}/contents/${dto.id}',
      options: AppConstants.dioOptions,
    );
  }
}

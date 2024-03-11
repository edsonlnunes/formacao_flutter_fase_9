import 'package:dio/dio.dart';

import '../../../shared/entities/content.entity.dart';
import '../../../utils/app.constants.dart';

class GetAllContentsService {
  final Dio dio;

  GetAllContentsService(this.dio);

  Future<List<Content>> call(int categoryId) async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/categories/$categoryId/contents',
      options: AppConstants.dioOptions,
    );

    return List<Content>.from(
      response.data.map((e) => Content.fromMap(e)),
    );
  }
}

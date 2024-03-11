import 'package:dio/dio.dart';

import '../../../utils/app.constants.dart';

class RemoveDeckService {
  final Dio dio;

  RemoveDeckService(this.dio);

  Future<void> call(int deckId) async {
    await dio.delete(
      '${AppConstants.baseUrl}/decks/$deckId',
      options: AppConstants.dioOptions,
    );
  }
}

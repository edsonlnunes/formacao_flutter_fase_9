import 'package:dio/dio.dart';

import '../../../shared/entities/deck.entity.dart';
import '../../../utils/app.constants.dart';

class AddDeckService {
  final Dio dio;

  AddDeckService(this.dio);

  Future<Deck> call(String name) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/decks',
      data: {'name': name},
      options: AppConstants.dioOptions,
    );

    return Deck.fromMap(response.data);
  }
}

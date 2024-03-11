import 'package:dio/dio.dart';

import '../../../shared/entities/deck.entity.dart';
import '../../../utils/app.constants.dart';

class GetAllDecksService {
  final Dio dio;

  GetAllDecksService(this.dio);

  Future<List<Deck>> call() async {
    final response = await dio.get(
      '${AppConstants.baseUrl}/decks',
      options: AppConstants.dioOptions,
    );

    return List<Deck>.from(response.data.map((e) => Deck.fromMap(e)));
  }
}

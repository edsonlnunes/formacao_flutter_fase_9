import 'package:dio/dio.dart';

import '../../../shared/entities/question.entity.dart';
import '../../../utils/app.constants.dart';
import '../dtos/add_question.dto.dart';

class AddQuestionService {
  final Dio dio;

  AddQuestionService(this.dio);

  Future<Question> call(AddQuestionDTO dto) async {
    final response = await dio.post(
      '${AppConstants.baseUrl}/decks/${dto.deckId}/questions',
      data: dto.toMap(),
      options: AppConstants.dioOptions,
    );

    return Question.fromMap(response.data);
  }
}

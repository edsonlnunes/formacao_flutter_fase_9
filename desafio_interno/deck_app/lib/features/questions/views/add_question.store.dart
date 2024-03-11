import 'package:deck_app/features/questions/dtos/add_question.dto.dart';
import 'package:deck_app/features/questions/services/add_question.service.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/entities/question.entity.dart';

part 'add_question.store.g.dart';

class AddQuestionStore = AddQuestionStoreBase with _$AddQuestionStore;

abstract class AddQuestionStoreBase with Store {
  final AddQuestionService _addQuestionService;

  AddQuestionStoreBase(this._addQuestionService);

  @observable
  bool isLoading = false;

  @observable
  String? failure;

  @action
  clearFailure() => failure = null;

  @action
  Future<Question?> addNewQuestion({
    required String ask,
    required String answer,
    required int deckId,
  }) async {
    
    clearFailure();
    isLoading = true;

    try {
      final tempQuestion = await _addQuestionService(
        AddQuestionDTO(deckId: deckId, ask: ask, answer: answer),
      );

      isLoading = false;

      return tempQuestion;
    } on DioException catch (err) {
      final message = err.response?.data['error'];

      failure = message;
      isLoading = false;

      return null;
    }
  }
}


import 'package:deck_app/features/questions/dtos/add_question.dto.dart';

class AddQuestionDTOBuilder {
  final int _deckId = 1;
  final String _ask = 'any_ask';
  final String _answer = 'any_answer';

  static AddQuestionDTOBuilder init() => AddQuestionDTOBuilder();

  AddQuestionDTO build() {
    return AddQuestionDTO(
      deckId: _deckId,
      ask: _ask,
      answer: _answer,
    );
  }
}

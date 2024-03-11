import 'package:deck_app/features/questions/services/add_question.service.dart';
import 'package:deck_app/features/questions/views/add_question.store.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../builders/features/questions/dtos/add_question.dto.builder.dart';

class MockDio extends Mock implements Dio {}

AddQuestionStore makeStore(MockDio dio) {
  return AddQuestionStore(AddQuestionService(dio));
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('AddQuestionStore -', () {
    final dto = AddQuestionDTOBuilder.init().build();
    final route = '${AppConstants.baseUrl}/decks/${dto.deckId}/questions';
    final questionMap = {
      'id': 1,
      'ask': dto.ask,
      'answer': dto.answer,
    };

    test('Deve adicionar uma Question', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: questionMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.addNewQuestion(
        ask: dto.ask,
        answer: dto.answer,
        deckId: dto.deckId,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
    });

    test('Deve preencher estado de failure ao tentar adicionar uma Question',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'success': false,
              'code': 500,
              'error': 'any_message',
            },
            statusCode: 500,
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.addNewQuestion(
        ask: dto.ask,
        answer: dto.answer,
        deckId: dto.deckId,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, equals('any_message'));
    });
  });
}

import 'package:deck_app/features/questions/services/add_question.service.dart';
import 'package:deck_app/shared/entities/question.entity.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../builders/features/questions/dtos/add_question.dto.builder.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final AddQuestionService sut;

  setUpAll(() {
    dio = MockDio();
    sut = AddQuestionService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('AddQuestionService -', () {
    final dto = AddQuestionDTOBuilder.init().build();
    final route = '${AppConstants.baseUrl}/decks/${dto.deckId}/questions';
    final questionMap = {
      'id': 1,
      'ask': dto.ask,
      'answer': dto.answer,
    };

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: questionMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(dto);

      verify(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).called(1);
    });

    test('Deve ser lançado um erro, caso seja retornado pela chamada da rota',
        () async {
      final dioException = DioException(
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
      );

      when(
        () => dio.post(
          route,
          data: dto.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenThrow(dioException);

      expect(() async => sut(dto), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar uma Question', () async {
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

      final result = await sut(dto);

      expect(result, equals(Question.fromMap(questionMap)));
    });
  });
}

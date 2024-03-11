import 'package:deck_app/features/main/services/get_all_decks.service.dart';
import 'package:deck_app/shared/entities/deck.entity.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final GetAllDecksService sut;

  setUpAll(() {
    dio = MockDio();
    sut = GetAllDecksService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('GetAllDecksService -', () {
    const route = '${AppConstants.baseUrl}/decks';
    final decksMap = [
      {
        'id': 1,
        'name': 'first_deck',
        'questions': [],
      },
      {
        'id': 2,
        'name': 'second_deck',
        'questions': [],
      },
    ];

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: decksMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut();

      verify(
        () => dio.get(route, options: AppConstants.dioOptions),
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
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenThrow(dioException);

      expect(() async => sut(), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar uma lista de Deck',
        () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: decksMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      final result = await sut();

      expect(
        result,
        equals(
          [
            Deck.fromMap(decksMap[0]),
            Deck.fromMap(decksMap[1]),
          ],
        ),
      );
    });
  });
}

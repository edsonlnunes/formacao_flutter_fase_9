import 'package:deck_app/features/main/services/add_deck.service.dart';
import 'package:deck_app/shared/entities/deck.entity.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final AddDeckService sut;

  setUpAll(() {
    dio = MockDio();
    sut = AddDeckService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('AddDeckService -', () {
    const name = 'any_name';
    const route = '${AppConstants.baseUrl}/decks';
    final nameMap = {'name': name};
    final deckMap = {
      'id': 1,
      'name': name,
      'questions': [],
    };

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.post(
          route,
          data: nameMap,
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: deckMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(name);

      verify(
        () => dio.post(
          route,
          data: nameMap,
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
          data: nameMap,
          options: AppConstants.dioOptions,
        ),
      ).thenThrow(dioException);

      expect(() async => sut(name), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar um Deck', () async {
      when(
        () => dio.post(
          route,
          data: nameMap,
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: deckMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      final result = await sut(name);

      expect(result, equals(Deck.fromMap(deckMap)));
    });
  });
}

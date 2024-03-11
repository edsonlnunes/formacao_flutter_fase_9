import 'package:deck_app/features/main/services/remove_deck.service.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final RemoveDeckService sut;

  setUpAll(() {
    dio = MockDio();
    sut = RemoveDeckService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('RemoveDeckService -', () {
    const deckId = 1;
    const route = '${AppConstants.baseUrl}/decks/$deckId';

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(deckId);

      verify(
        () => dio.delete(route, options: AppConstants.dioOptions),
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
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenThrow(dioException);

      expect(() async => sut(deckId), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso', () async {
      when(
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expectSync(sut(deckId), isA<void>());
    });
  });
}

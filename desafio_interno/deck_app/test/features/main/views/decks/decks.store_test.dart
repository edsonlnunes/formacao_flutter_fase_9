import 'package:deck_app/features/main/services/add_deck.service.dart';
import 'package:deck_app/features/main/services/get_all_decks.service.dart';
import 'package:deck_app/features/main/services/remove_deck.service.dart';
import 'package:deck_app/features/main/views/decks/decks.store.dart';
import 'package:deck_app/shared/entities/deck.entity.dart';
import 'package:deck_app/utils/app.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

DecksStore makeStore(MockDio dio) {
  return DecksStore(
    AddDeckService(dio),
    GetAllDecksService(dio),
    RemoveDeckService(dio),
  );
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('DecksStore -', () {
    const route = '${AppConstants.baseUrl}/decks';
    const deckName = 'any_deck_name';
    final decksMap = [
      {
        'id': 1,
        'name': deckName,
        'questions': [],
      },
      {
        'id': 2,
        'name': deckName,
        'questions': [],
      },
    ];

    test('Deve retornar uma listagem de Deck', () async {
      final store = makeStore(dio);

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

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.getDecks();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, [
        Deck.fromMap(decksMap[0]),
        Deck.fromMap(decksMap[1]),
      ]);
    });

    test('Deve preencher estado de failure ao tentar listar os Decks',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
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

      await store.getDecks();

      expect(store.isLoading, isFalse);
      expect(store.decks, []);
      expect(store.failure, equals('any_message'));
    });

    final nameMap = {'name': deckName};

    test('Deve adicionar um Deck na listagem', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: nameMap,
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: decksMap[0],
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.addDeck(deckName);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, [Deck.fromMap(decksMap[0])]);
    });

    test('Deve preencher estado de failure ao tentar adicionar um Deck',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: nameMap,
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

      await store.addDeck(deckName);

      expect(store.isLoading, isFalse);
      expect(store.decks, []);
      expect(store.failure, equals('any_message'));
    });

    final deckId = decksMap[0]['id'] as int;
    final routeWithDeckId = '$route/$deckId';

    test('Deve remover um Deck da listagem', () async {
      final store = makeStore(dio);

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

      when(
        () => dio.delete(routeWithDeckId, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, []);

      await store.getDecks();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, [
        Deck.fromMap(decksMap[0]),
        Deck.fromMap(decksMap[1]),
      ]);

      await store.removeDeck(deckId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, [Deck.fromMap(decksMap[1])]);
    });

    test('Deve preencher estado de failure ao tentar remover um Deck',
        () async {
      final store = makeStore(dio);

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

      when(
        () => dio.delete(routeWithDeckId, options: AppConstants.dioOptions),
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
      expect(store.decks, []);

      await store.getDecks();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.decks, [
        Deck.fromMap(decksMap[0]),
        Deck.fromMap(decksMap[1]),
      ]);

      await store.removeDeck(deckId);

      expect(store.isLoading, isFalse);
      expect(
        store.decks,
        [
          Deck.fromMap(decksMap[0]),
          Deck.fromMap(decksMap[1]),
        ],
      );
      expect(store.failure, equals('any_message'));
    });
  });
}

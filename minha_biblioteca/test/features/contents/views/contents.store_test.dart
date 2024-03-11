import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:minha_biblioteca_fase_9/features/contents/views/contents/contents.store.dart';
import 'package:minha_biblioteca_fase_9/shared/models/content.model.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  const categoryId = 1;
  final mockDio = MockDio();

  setUpAll(() {
    GetIt.I.registerSingleton<Dio>(mockDio);
  });

  tearDown(() => reset(mockDio));

  tearDownAll(() {
    GetIt.I.unregister<Dio>();
  });

  group('ContentsStore Intregration Test -', () {
    group('getContents -', () {
      test('Deve popular a lista de conteudos com 2 elementos', () async {
        final sut = ContentsStore();

        when(
          () => mockDio.get(
            '/categories/$categoryId/contents',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: [
                {
                  "id": 1,
                  "name": "any_content",
                  "isChecked": false,
                },
                {
                  "id": 2,
                  "name": "any_content2",
                  "isChecked": true,
                }
              ],
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        await sut.getContents(categoryId);

        expect(
          sut.contents,
          [
            Content(id: 1, name: 'any_content'),
            Content(id: 2, name: 'any_content2', isChecked: true),
          ],
        );
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
      });

      test('Deve popular o estado de erro com a falha da requisição', () async {
        final sut = ContentsStore();

        when(
          () => mockDio.get(
            '/categories/$categoryId/contents',
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any_error',
              },
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        await sut.getContents(categoryId);

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, 'any_error');
      });
    });

    group('addNewContent -', () {
      test('Deve popular a lista de conteudos com 2 elementos', () async {
        final sut = ContentsStore();

        when(
          () => mockDio.post(
            '/categories/$categoryId/contents',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {
                "id": 1,
                "name": "any_content",
                "isChecked": false,
              },
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        var result =
            await sut.addNewContent(contentName: 'any_content', categoryId: 1);

        expect(result, isTrue);

        expect(sut.contents, [Content(id: 1, name: 'any_content')]);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        when(
          () => mockDio.post(
            '/categories/$categoryId/contents',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: {
                "id": 2,
                "name": "any_content2",
                "isChecked": false,
              },
            ),
          ),
        );

        result =
            await sut.addNewContent(contentName: 'any_content2', categoryId: 1);

        expect(result, isTrue);
        expect(sut.contents, [
          Content(id: 1, name: 'any_content'),
          Content(id: 2, name: 'any_content2'),
        ]);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
      });

      test('Deve popular o estado de erro com a falha da requisição', () async {
        final sut = ContentsStore();

        when(
          () => mockDio.post(
            '/categories/$categoryId/contents',
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any_error',
              },
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        await sut.addNewContent(contentName: 'any_content', categoryId: 1);

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, 'any_error');
      });
    });

    group('removeContent -', () {
      test('Deve popular a lista de conteudos com 2 elementos e remover 1',
          () async {
        final sut = ContentsStore();

        when(
          () => mockDio.get(
            '/categories/$categoryId/contents',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: [
                {
                  "id": 1,
                  "name": "any_content",
                  "isChecked": false,
                },
                {
                  "id": 2,
                  "name": "any_content2",
                  "isChecked": true,
                }
              ],
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        await sut.getContents(categoryId);

        expect(
          sut.contents,
          [
            Content(id: 1, name: 'any_content'),
            Content(id: 2, name: 'any_content2', isChecked: true),
          ],
        );
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        when(
          () => mockDio.delete(
            '/categories/$categoryId/contents/1',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: true,
            ),
          ),
        );

        final result = await sut.removeContent(
          contentId: 1,
          categoryId: categoryId,
        );

        expect(result, isTrue);

        expect(
          sut.contents,
          [Content(id: 2, name: 'any_content2', isChecked: true)],
        );
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);
      });

      test('Deve popular o estado de erro com a falha da requisição', () async {
        final sut = ContentsStore();

        when(
          () => mockDio.delete(
            '/categories/$categoryId/contents/1',
            options: any(named: 'options'),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any_error',
              },
            ),
          ),
        );

        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, isNull);

        final result = await sut.removeContent(
          categoryId: categoryId,
          contentId: 1,
        );

        expect(result, isFalse);
        expect(sut.contents, isEmpty);
        expect(sut.isLoading, isFalse);
        expect(sut.error, 'any_error');
      });
    });
  });
}

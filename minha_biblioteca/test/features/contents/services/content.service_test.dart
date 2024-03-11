import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minha_biblioteca_fase_9/features/contents/dtos/add_content.dto.dart';
import 'package:minha_biblioteca_fase_9/features/contents/dtos/remove_content.dto.dart';
import 'package:minha_biblioteca_fase_9/features/contents/dtos/update_content.dto.dart';
import 'package:minha_biblioteca_fase_9/features/contents/services/content.service.dart';
import 'package:minha_biblioteca_fase_9/shared/models/content.model.dart';
import 'package:minha_biblioteca_fase_9/shared/models/custom_error.model.dart';
import 'package:minha_biblioteca_fase_9/shared/utils/constants.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = ContentService(mockDio);

  setUp(() => reset(mockDio));

  group('ContentService Unit Test -', () {
    group('createContent -', () {
      test('Deve retornar a entidade Content preenchida', () async {
        // dado
        final dto = AddContentDto(
          categoryId: 1,
          name: 'any_content',
        );

        when(
          () => mockDio.post(
            '/categories/${dto.categoryId}/contents',
            data: dto.toMap(),
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

        // quando
        final result = await sut.createContent(dto);

        // entao
        // expect(result.id, 1);
        // expect(result.name, 'any_content');
        // expect(result.isChecked, false);
        expect(result, Content(id: 1, name: 'any_content'));
      });

      test('Deve retornar um CustomError ao falhar a requisição', () async {
        // dado
        final dto = AddContentDto(
          categoryId: 1,
          name: 'any_content',
        );

        when(
          () => mockDio.post(
            '/categories/${dto.categoryId}/contents',
            data: dto.toMap(),
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

        // quando
        final future = sut.createContent(dto);

        // entao
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'description error',
              'any_error',
            ),
          ),
        );
      });
    });

    group('getContents -', () {
      test('Deve retornar uma lista de Contents vazia', () async {
        // dado
        when(
          () => mockDio.get(
            '/categories/1/contents',
            options: any(named: 'options'),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: [],
            ),
          ),
        );

        // quando
        final result = await sut.getContents(1);

        // entao
        expect(result, equals([]));
      });

      test('Deve retornar uma lista com 2 Contents', () async {
        // dado
        when(
          () => mockDio.get(
            '/categories/1/contents',
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

        // quando
        final result = await sut.getContents(1);

        // entao
        expect(
          result,
          equals(
            [
              Content(id: 1, name: 'any_content'),
              Content(id: 2, name: 'any_content2', isChecked: true),
            ],
          ),
        );
      });

      test('Deve retornar um CustomError ao falhar a requisição', () async {
        // dado
        when(
          () => mockDio.get(
            '/categories/1/contents',
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

        // quando
        final future = sut.getContents(1);

        // entao
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'description error',
              'any_error',
            ),
          ),
        );
      });
    });

    group('updateContent -', () {
      test('Deve atualizar na API e não deve retornar nada de resposta',
          () async {
        // dado
        final dto = UpdateContentDto(
          categoryId: 1,
          contentId: 1,
          isChecked: true,
        );

        when(
          () => mockDio.put(
            '/categories/${dto.categoryId}/contents/${dto.contentId}',
            data: dto.toMap(),
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

        // quando
        // entao
        expect(sut.updateContent(dto), isA<void>());
      });

      test('Deve retornar um CustomError ao falhar a requisição', () async {
        // dado
        final dto = UpdateContentDto(
          categoryId: 1,
          contentId: 1,
          isChecked: true,
        );

        when(
          () => mockDio.put(
            '/categories/${dto.categoryId}/contents/${dto.contentId}',
            data: dto.toMap(),
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

        // quando
        final future = sut.updateContent(dto);

        // entao
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'description error',
              'any_error',
            ),
          ),
        );
      });
    });

    group('removeContent -', () {
      test('Deve remover na API e não deve retornar nada de resposta',
          () async {
        // dado
        final dto = RemoveContentDto(
          categoryId: 1,
          contentId: 1,
        );

        when(
          () => mockDio.delete(
            '/categories/${dto.categoryId}/contents/${dto.contentId}',
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

        // quando
        // entao
        expect(sut.removeContent(dto), isA<void>());
      });

      test('Deve retornar um CustomError ao falhar a requisição', () async {
        // dado
        final dto = RemoveContentDto(
          categoryId: 1,
          contentId: 1,
        );

        when(
          () => mockDio.delete(
            '/categories/${dto.categoryId}/contents/${dto.contentId}',
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

        // quando
        final future = sut.removeContent(dto);

        // entao
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'description error',
              'any_error',
            ),
          ),
        );
      });
    });
  });
}

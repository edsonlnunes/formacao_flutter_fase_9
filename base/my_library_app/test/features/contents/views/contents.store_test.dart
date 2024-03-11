import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/contents/services/add_content.service.dart';
import 'package:my_library_app/features/contents/services/get_all_contents.service.dart';
import 'package:my_library_app/features/contents/services/remove_content.service.dart';
import 'package:my_library_app/features/contents/views/contents.store.dart';
import 'package:my_library_app/shared/entities/content.entity.dart';
import 'package:my_library_app/utils/app.constants.dart';

import '../../../builders/features/contents/dtos/add_content.dto.builder.dart';

class MockDio extends Mock implements Dio {}

ContentsStore makeStore(MockDio dio) {
  return ContentsStore(
    GetAllContentsService(dio),
    AddContentService(dio),
    RemoveContentService(dio),
  );
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('ContentsStore -', () {
    const categoryId = 1;
    const route = '${AppConstants.baseUrl}/categories/$categoryId/contents';
    final contentsMap = [
      {
        'id': 1,
        'name': 'first_content',
        'isChecked': false,
      },
      {
        'id': 2,
        'name': 'second_content',
        'isChecked': true,
      },
    ];

    test('Deve retornar uma listagem de Content', () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: contentsMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.getContents(categoryId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.contents, [
        Content.fromMap(contentsMap[0]),
        Content.fromMap(contentsMap[1]),
      ]);
    });

    test('Deve preencher estado de failure ao tentar listar os conteúdos',
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

      await store.getContents(categoryId);

      expect(store.isLoading, isFalse);
      expect(store.contents, []);
      expect(store.failure, equals('any_message'));
    });

    final addContentDTO = AddContentDTOBuilder.init().build();

    test('Deve adicionar um conteúdo na listagem', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: addContentDTO.toMap(),
          options: AppConstants.dioOptions,
        ),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: contentsMap[0],
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.addNewContent(
        categoryId: addContentDTO.categoryId,
        contentName: addContentDTO.name,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.contents, [Content.fromMap(contentsMap[0])]);
    });

    test('Deve preencher estado de failure ao tentar adicionar um conteúdo',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.post(
          route,
          data: addContentDTO.toMap(),
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

      await store.addNewContent(
        categoryId: addContentDTO.categoryId,
        contentName: addContentDTO.name,
      );

      expect(store.isLoading, isFalse);
      expect(store.contents, []);
      expect(store.failure, equals('any_message'));
    });

    final contentId = contentsMap[0]['id'] as int;
    final routeWithContentId = '$route/$contentId';

    test('Deve remover um conteúdo da listagem', () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: contentsMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      when(
        () => dio.delete(routeWithContentId, options: AppConstants.dioOptions),
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
      expect(store.contents, []);

      await store.getContents(categoryId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.contents, [
        Content.fromMap(contentsMap[0]),
        Content.fromMap(contentsMap[1]),
      ]);

      await store.removeContent(categoryId: categoryId, contentId: contentId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.contents, [Content.fromMap(contentsMap[1])]);
    });

    test('Deve preencher estado de failure ao tentar remover um conteúdo',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: contentsMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      when(
        () => dio.delete(routeWithContentId, options: AppConstants.dioOptions),
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
      expect(store.contents, []);

      await store.getContents(categoryId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.contents, [
        Content.fromMap(contentsMap[0]),
        Content.fromMap(contentsMap[1]),
      ]);

      await store.removeContent(categoryId: categoryId, contentId: contentId);

      expect(store.isLoading, isFalse);
      expect(
        store.contents,
        [
          Content.fromMap(contentsMap[0]),
          Content.fromMap(contentsMap[1]),
        ],
      );
      expect(store.failure, equals('any_message'));
    });
  });
}

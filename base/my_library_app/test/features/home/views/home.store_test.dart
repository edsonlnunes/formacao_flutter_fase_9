import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/home/services/get_all_categories.service.dart';
import 'package:my_library_app/features/home/services/remove_category.service.dart';
import 'package:my_library_app/features/home/views/home.store.dart';
import 'package:my_library_app/shared/entities/category.entity.dart';
import 'package:my_library_app/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

HomeStore makeStore(MockDio dio) {
  return HomeStore(
    GetAllCategoriesService(dio),
    RemoveCategoryService(dio),
  );
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('HomeStore -', () {
    const categoryId = 1;
    const route = '${AppConstants.baseUrl}/categories';
    final categoriesMap = [
      {
        'id': 1,
        'name': 'first_category',
        'filePath': 'first_file_path',
      },
      {
        'id': 2,
        'name': 'second_category',
        'filePath': 'second_file_path',
      },
    ];

    test('Deve retornar uma listagem de Category', () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: categoriesMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      await store.getCategories();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.categories, [
        Category.fromMap(categoriesMap[0]),
        Category.fromMap(categoriesMap[1]),
      ]);
    });

    test('Deve preencher estado de failure ao tentar listar as categorias',
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

      await store.getCategories();

      expect(store.isLoading, isFalse);
      expect(store.categories, []);
      expect(store.failure, equals('any_message'));
    });

    const routeWithCategoryId = '$route/$categoryId';

    test('Deve remover uma categoria da listagem', () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: categoriesMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      when(
        () => dio.delete(routeWithCategoryId, options: AppConstants.dioOptions),
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
      expect(store.categories, []);

      await store.getCategories();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.categories, [
        Category.fromMap(categoriesMap[0]),
        Category.fromMap(categoriesMap[1]),
      ]);

      await store.removeCategory(categoryId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.categories, [Category.fromMap(categoriesMap[1])]);
    });

    test('Deve preencher estado de failure ao tentar remover uma categoria',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: categoriesMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      when(
        () => dio.delete(routeWithCategoryId, options: AppConstants.dioOptions),
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
      expect(store.categories, []);

      await store.getCategories();

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(store.categories, [
        Category.fromMap(categoriesMap[0]),
        Category.fromMap(categoriesMap[1]),
      ]);

      await store.removeCategory(categoryId);

      expect(store.isLoading, isFalse);
      expect(
        store.categories,
        [
          Category.fromMap(categoriesMap[0]),
          Category.fromMap(categoriesMap[1]),
        ],
      );
      expect(store.failure, equals('any_message'));
    });
  });
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/home/services/add_category.service.dart';
import 'package:my_library_app/features/home/views/widgets/new_category/add_category.store.dart';
import 'package:my_library_app/utils/app.constants.dart';

import '../../../../../builders/features/home/dtos/add_category.dto.builder.dart';

class MockDio extends Mock implements Dio {}

AddCategoryStore makeStore(MockDio dio) {
  return AddCategoryStore(AddCategoryService(dio));
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('AddCategoryStore -', () {
    const route = '${AppConstants.baseUrl}/categories';
    final dto = AddCategoryDTOBuilder.init().build();
    final categoryMap = {
      'id': 1,
      'name': dto.name,
      'filePath': dto.filePath,
    };

    test('Deve adicionar uma Category', () async {
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
            data: categoryMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      store.setImage(File(dto.filePath!));

      await store.addCategory(dto.name);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
    });

    test('Deve preencher estado de failure ao tentar adicionar uma categoria',
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

      store.setImage(File(dto.filePath!));

      await store.addCategory(dto.name);

      expect(store.isLoading, isFalse);
      expect(store.failure, equals('any_message'));
    });
  });
}

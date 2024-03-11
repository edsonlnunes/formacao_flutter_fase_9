import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/contents/services/update_content.service.dart';
import 'package:my_library_app/features/contents/views/widgets/card_content/update_content.store.dart';
import 'package:my_library_app/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

UpdateContentStore makeStore(MockDio dio) {
  return UpdateContentStore(UpdateContentService(dio));
}

void main() {
  late final MockDio dio;

  setUpAll(() => [dio = MockDio(), AppConstants.token = 'any_token']);
  tearDown(() => reset(dio));

  group('RegisterStore -', () {
    const categoryId = 1;
    const contentId = 1;
    const route =
        '${AppConstants.baseUrl}/categories/$categoryId/contents/$contentId';
    const isCheckedMap = {'isChecked': true};

    test('Deve atualizar a propriedade isChecked de um Content', () async {
      final store = makeStore(dio);

      when(
        () => dio.put(
          route,
          data: isCheckedMap,
          options: AppConstants.dioOptions,
        ),
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

      await store.updateIsChecked(categoryId: categoryId, contentId: contentId);

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
    });

    test(
        'Deve preencher estado de failure ao tentar atualizar a propriedade isChecked de um Content',
        () async {
      final store = makeStore(dio);

      when(
        () => dio.put(
          route,
          data: isCheckedMap,
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

      await store.updateIsChecked(categoryId: categoryId, contentId: contentId);

      expect(store.isLoading, isFalse);
      expect(store.failure, equals('any_message'));
    });
  });
}

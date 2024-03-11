import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:deck_app/features/authentication/services/register.service.dart';
import 'package:deck_app/features/authentication/views/register/register.store.dart';
import 'package:deck_app/utils/app.constants.dart';

import '../../../../builders/features/authentication/dtos/account.dto.builder.dart';

class MockDio extends Mock implements Dio {}

RegisterStore makeStore(MockDio dio) {
  return RegisterStore(
    RegisterService(dio),
  );
}

void main() {
  late final MockDio dio;

  setUpAll(() => dio = MockDio());
  tearDown(() => reset(dio));

  group('RegisterStore -', () {
    final dto = AccountDTOBuilder.init().build();
    const route = '${AppConstants.baseUrl}/register';

    test('Deve retornar true ao registrar', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(route, data: dto.toMap()),
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

      final result = await store.register(
        email: dto.email,
        password: dto.password,
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);
      expect(result, isTrue);
    });

    test('Deve preencher estado de failure', () async {
      final store = makeStore(dio);

      when(
        () => dio.post(route, data: dto.toMap()),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {
              'success': false,
              'code': 500,
              'error': {
                'process': 'any',
                'message': 'any_message',
                'details': [],
              }
            },
            statusCode: 500,
          ),
        ),
      );

      expect(store.isLoading, isFalse);
      expect(store.failure, isNull);

      final result = await store.register(
        email: dto.email,
        password: dto.password,
      );

      expect(store.isLoading, isFalse);
      expect(result, isFalse);
      expect(store.failure, equals('any_message'));
    });
  });
}

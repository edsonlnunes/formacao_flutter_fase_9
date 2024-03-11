import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/authentication/services/register.service.dart';
import 'package:my_library_app/utils/app.constants.dart';

import '../../../builders/features/authentication/dtos/account.dto.builder.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final RegisterService sut;

  setUpAll(() {
    dio = MockDio();
    sut = RegisterService(dio);
  });

  tearDown(() => reset(dio));

  group('RegisterService -', () {
    const route = '${AppConstants.baseUrl}/register';
    final dto = AccountDTOBuilder.init().build();

    test('Deve chamar o método passando os parametros esperados', () async {
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

      await sut(dto);

      verify(() => dio.post(route, data: dto.toMap())).called(1);
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
        () => dio.post(route, data: dto.toMap()),
      ).thenThrow(dioException);

      expect(() async => sut(dto), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso', () async {
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

      expectSync(sut(dto), isA<void>());
    });
  });
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/authentication/services/login.service.dart';
import 'package:my_library_app/utils/app.constants.dart';

import '../../../builders/features/authentication/dtos/account.dto.builder.dart';

class MockDio extends Mock implements Dio {}

/*
“Se você não gosta de testar seu produto, grandes chances de seus clientes também não gostarem.”
*/

void main() {
  late final Dio dio;
  late final LoginService sut;

  setUpAll(() {
    dio = MockDio();
    sut = LoginService(dio);
  });

  tearDown(() => reset(dio));

  group('LoginService -', () {
    const route = '${AppConstants.baseUrl}/login';
    final dto = AccountDTOBuilder.init().build();
    const token = 'any_token';

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.post(route, data: dto.toMap()),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: token,
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

      expect(() async => await sut(dto), throwsA(dioException));
    });

    test('Deve retornar sucesso com o token', () async {
      when(
        () => dio.post(route, data: dto.toMap()),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: token,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      final result = await sut(dto);

      expect(result, equals(token));
    });
  });
}

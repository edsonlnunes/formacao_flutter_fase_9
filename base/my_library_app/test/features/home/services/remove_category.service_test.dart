import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/home/services/remove_category.service.dart';
import 'package:my_library_app/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final RemoveCategoryService sut;

  setUpAll(() {
    dio = MockDio();
    sut = RemoveCategoryService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('RemoveCategoryService -', () {
    const categoryId = 1;
    const route = '${AppConstants.baseUrl}/categories/$categoryId';

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(categoryId);

      verify(
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).called(1);
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
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenThrow(dioException);

      expect(() async => sut(categoryId), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso', () async {
      when(
        () => dio.delete(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      expectSync(sut(categoryId), isA<void>());
    });
  });
}

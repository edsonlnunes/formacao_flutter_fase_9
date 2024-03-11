import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/contents/services/get_all_contents.service.dart';
import 'package:my_library_app/shared/entities/content.entity.dart';
import 'package:my_library_app/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final GetAllContentsService sut;

  setUpAll(() {
    dio = MockDio();
    sut = GetAllContentsService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('GetAllContentsService -', () {
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

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: contentsMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut(categoryId);

      verify(
        () => dio.get(route, options: AppConstants.dioOptions),
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
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenThrow(dioException);

      expect(() async => sut(categoryId), throwsA(dioException));
    });

    test('Deve consumir a rota com sucesso e retornar uma lista de Content',
        () async {
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

      final result = await sut(categoryId);

      expect(
        result,
        equals(
          [
            Content.fromMap(contentsMap[0]),
            Content.fromMap(contentsMap[1]),
          ],
        ),
      );
    });
  });
}

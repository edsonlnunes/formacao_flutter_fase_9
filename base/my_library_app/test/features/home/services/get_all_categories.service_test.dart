import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_library_app/features/home/services/get_all_categories.service.dart';
import 'package:my_library_app/shared/entities/category.entity.dart';
import 'package:my_library_app/utils/app.constants.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late final Dio dio;
  late final GetAllCategoriesService sut;

  setUpAll(() {
    dio = MockDio();
    sut = GetAllCategoriesService(dio);
    AppConstants.token = 'any_token';
  });

  tearDown(() => reset(dio));

  group('GetAllCategoriesService -', () {
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
    final categoriesWithoutFilePathMap = [
      {
        'id': 1,
        'name': 'first_category',
      },
      {
        'id': 2,
        'name': 'second_category',
      },
    ];

    test('Deve chamar o método passando os parametros esperados', () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) async => Future.value(
          Response(
            data: categoriesMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      await sut();

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

      expect(() async => sut(), throwsA(dioException));
    });

    test(
        'Deve consumir a rota com sucesso e retornar uma lista de Category sem filePath',
        () async {
      when(
        () => dio.get(route, options: AppConstants.dioOptions),
      ).thenAnswer(
        (_) => Future.value(
          Response(
            data: categoriesWithoutFilePathMap,
            statusCode: 200,
            requestOptions: RequestOptions(path: route),
          ),
        ),
      );

      final result = await sut();

      expect(
        result,
        equals(
          [
            Category.fromMap(categoriesWithoutFilePathMap[0]),
            Category.fromMap(categoriesWithoutFilePathMap[1]),
          ],
        ),
      );
    });

    test('Deve consumir a rota com sucesso e retornar uma lista de Category',
        () async {
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

      final result = await sut();

      expect(
        result,
        equals(
          [
            Category.fromMap(categoriesMap[0]),
            Category.fromMap(categoriesMap[1]),
          ],
        ),
      );
    });
  });
}

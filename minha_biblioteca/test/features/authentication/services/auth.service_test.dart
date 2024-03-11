import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minha_biblioteca_fase_9/features/authentication/dtos/auth.dto.dart';
import 'package:minha_biblioteca_fase_9/features/authentication/services/auth.service.dart';
import 'package:minha_biblioteca_fase_9/shared/models/custom_error.model.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final mockDio = MockDio();
  final sut = AuthService(mockDio);
  final authDto = AuthDto(
    email: 'teste@teste.com',
    pass: '123456',
  );

  setUp(() => reset(mockDio));

  // // vai rodar antes do primeiro test
  // setUpAll(() => print('setUpAll'));

  // // vai rodar antes de cada test
  // setUp(() => print("setUp"));

  // // vai rodar depois de cada test
  // tearDown(() => print('tearDown'));

  // // vai rodar depois do último test executado
  // tearDownAll(() => print('tearDownAll'));

  group('AuthService Unit Test -', () {
    group('createAccount -', () {
      test('Deve fazer a requisição com sucesso e validar a chamada do dio',
          () async {
        // Dado (given)
        when(
          () => mockDio.post(
            '/register',
            data: authDto.toMap(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              statusCode: 200,
              requestOptions: RequestOptions(),
            ),
          ),
        );

        // Quando (when)
        final result = await sut.createAccount(authDto);

        // Então (then)
        expect(result, isTrue);
      });

      test('Deve ocorrer a exceção e retornar um CustomError', () {
        // dado (given)
        when(
          () => mockDio.post(
            '/register',
            data: authDto.toMap(),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any error',
              },
              statusCode: 400,
            ),
          ),
        );

        // quando (when)
        final future = sut.createAccount(authDto);

        // entao (then)
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'valida prop message',
              'any error',
            ),
          ),
        );
      });
    });

    group('login -', () {
      test('Deve retornar o token do usuario ao fazer o login', () async {
        // Dado (given)
        when(
          () => mockDio.post(
            '/login',
            data: authDto.toMap(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: 'any_token',
            ),
          ),
        );

        // Quando (when)
        final result = await sut.login(authDto);

        // Então (then)
        expect(result, equals('any_token'));
      });

      test('Deve retornar um CustomError ao falhar a requisição', () async {
        when(
          () => mockDio.post(
            '/login',
            data: authDto.toMap(),
          ),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(),
            response: Response(
              requestOptions: RequestOptions(),
              data: {
                'error': 'any error',
              },
              statusCode: 400,
            ),
          ),
        );

        // Quando (when)
        final future = sut.login(authDto);

        // Então (then)
        expect(
          future,
          throwsA(
            isA<CustomError>().having(
              (error) => error.message,
              'valida prop message',
              'any error',
            ),
          ),
        );
      });
    });
  });
}

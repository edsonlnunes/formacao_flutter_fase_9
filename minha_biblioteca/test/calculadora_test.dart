import 'package:flutter_test/flutter_test.dart';
import 'package:minha_biblioteca_fase_9/calculadora.dart';

void main() {
  group('Calculadora Unit Test -', () {
    test('Deve somar 5 com 5', () {
      // system under test
      final sut = Calculadora();

      final resultado = sut.somar(5, 5);

      expect(resultado, equals(10));
      expect(sut.historico, equals(['5.0 + 5.0 = 10.0']));
    });

    test('Deve diminuir 10 com 5', () {
      // system under test
      final sut = Calculadora();

      final resultado = sut.diminuir(10, 5);

      expect(resultado, equals(5));
      expect(sut.historico, equals(['10.0 - 5.0 = 5.0']));
    });

    test('Deve dividir 50 com 2, somar 50 com 2 e manter o histórico', () {
      // system under test
      final sut = Calculadora();

      var resultado = sut.dividir(50, 2);
      expect(resultado, equals(25));
      expect(sut.historico, equals(['50.0 / 2.0 = 25.0']));

      resultado = sut.somar(50, 2);
      expect(resultado, equals(52));
      expect(sut.historico, equals(['50.0 / 2.0 = 25.0', '50.0 + 2.0 = 52.0']));
    });
  });
}

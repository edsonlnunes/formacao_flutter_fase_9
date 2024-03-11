class Calculadora {
  final List<String> historico = [];

  double somar(double num1, double num2) {
    final resultado = num1 + num2;
    historico.add('$num1 + $num2 = $resultado');
    return resultado;
  }

  double diminuir(double num1, double num2) {
    final resultado = num1 - num2;
    historico.add('$num1 - $num2 = $resultado');
    return resultado;
  }

  double multiplicar(double num1, double num2) {
    final resultado = num1 * num2;
    historico.add('$num1 * $num2 = $resultado');
    return resultado;
  }

  double dividir(double num1, double num2) {
    final resultado = num1 / num2;
    historico.add('$num1 / $num2 = $resultado');
    return resultado;
  }
}

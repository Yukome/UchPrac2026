import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uchprac1/logic/calculator.dart';

void main() {
  group('Calculator Logic', () {
    test('Сложение', () {
      final result = calculate('2', 'add', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Вычитание', () {
      final result = calculate('5', 'sub', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 2.0);
    });

    test('Умножение', () {
      final result = calculate('4', 'mul', '3');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 12.0);
    });

    test('Деление', () {
      final result = calculate('10', 'div', '2');
      expect(result, isA<CalcSuccess>());
      expect((result as CalcSuccess).value, 5.0);
    });

    test('Деление на ноль', () {
      final result = calculate('10', 'div', '0');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, contains('Деление на ноль'));
    });

    test('Нечисловой ввод', () {
      final result = calculate('abc', 'add', '3');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, contains('не числа'));
    });

    test('Неизвестная операция', () {
      final result = calculate('2', 'unknown', '3');
      expect(result, isA<CalcFailure>());
      expect((result as CalcFailure).message, contains('Неизвестная операция'));
    });

    test('Отсутствие параметра', () {
      final result = calculate(null, 'add', '3');
      expect(result, isA<CalcFailure>());
    });
  });
}
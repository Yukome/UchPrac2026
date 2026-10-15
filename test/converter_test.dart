import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uchprac1/logic/currency.dart';

void main() {
  group('Converter Logic', () {
    test('USD → EUR', () {
      final result = convert('100', 'USD', 'EUR');
      expect(result, isA<ConversionSuccess>());
      expect((result as ConversionSuccess).value, closeTo(92.0, 0.01));
    });

    test('EUR → USD', () {
      final result = convert('92', 'EUR', 'USD');
      expect(result, isA<ConversionSuccess>());
      expect((result as ConversionSuccess).value, closeTo(100.0, 0.01));
    });

    test('RUB → USD', () {
      final result = convert('925', 'RUB', 'USD');
      expect(result, isA<ConversionSuccess>());
      expect((result as ConversionSuccess).value, closeTo(10.0, 0.01));
    });

    test('Отрицательная сумма', () {
      final result = convert('-10', 'USD', 'EUR');
      expect(result, isA<ConversionFailure>());
      expect((result as ConversionFailure).message, contains('отрицательной'));
    });

    test('Неизвестная валюта', () {
      final result = convert('100', 'USD', 'XYZ');
      expect(result, isA<ConversionFailure>());
      expect((result as ConversionFailure).message, contains('Неизвестная валюта'));
    });

    test('Нечисловой ввод', () {
      final result = convert('abc', 'USD', 'EUR');
      expect(result, isA<ConversionFailure>());
      expect((result as ConversionFailure).message, contains('не сумма'));
    });

    test('Отсутствие параметра', () {
      final result = convert(null, 'USD', 'EUR');
      expect(result, isA<ConversionFailure>());
      expect((result as ConversionFailure).message, contains('не сумма'));
    });
  });
}
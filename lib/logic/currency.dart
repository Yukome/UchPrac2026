const Map<String, double> currencyRates = {
  'USD': 1.0,
  'EUR': 0.92,
  'RUB': 92.5,
  'GBP': 0.79,
  'CNY': 7.24,
};

sealed class ConversionResult {
  const ConversionResult();
}

class ConversionSuccess extends ConversionResult {
  final double value;
  const ConversionSuccess(this.value);
}

class ConversionFailure extends ConversionResult {
  final String message;
  const ConversionFailure(this.message);
}

ConversionResult convert(String? rawAmount, String? from, String? to) {
  final amount = double.tryParse(rawAmount?.replaceAll(',', '.') ?? '');
  if (amount == null) {
    return const ConversionFailure('В адресе передана не сумма');
  }

  if (from == null || to == null || !currencyRates.containsKey(from) || !currencyRates.containsKey(to)) {
    return const ConversionFailure('Неизвестная валюта');
  }

  if (amount < 0) {
    return const ConversionFailure('Сумма не может быть отрицательной');
  }

  final inUsd = amount / currencyRates[from]!;
  final result = inUsd * currencyRates[to]!;

  return ConversionSuccess(result);
}
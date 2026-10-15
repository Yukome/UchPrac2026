import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../logic/calculator.dart';
import '../logic/currency.dart';

class ResultScreen extends StatelessWidget {
  final String title;
  final String expression;
  final Map<String, String> rawQuery;
  final String backPath;
  final bool converterMode;

  const ResultScreen({
    super.key,
    required this.title,
    required this.expression,
    required this.rawQuery,
    required this.backPath,
    this.converterMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final result = converterMode
        ? convert(rawQuery['amount'], rawQuery['from'], rawQuery['to'])
        : calculate(rawQuery['a'], rawQuery['op'], rawQuery['b']);

    String resultText;
    bool isError = false;

    if (result is CalcSuccess) {
      resultText = _formatNumber(result.value);
    } else if (result is ConversionSuccess) {
      resultText = _formatNumber(result.value);
    } else if (result is CalcFailure) {
      resultText = result.message;
      isError = true;
    } else if (result is ConversionFailure) {
      resultText = result.message;
      isError = true;
    } else {
      resultText = 'Неизвестная ошибка';
      isError = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  expression,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 24),

                Text(
                  resultText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isError
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                ),

                const SizedBox(height: 32),

                FilledButton.icon(
                  onPressed: () => context.go(backPath),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Вернуться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }

    return value
        .toStringAsFixed(6)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }
}
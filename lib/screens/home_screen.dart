import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = themeNotifier.value == ThemeMode.dark;
    themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setBool('isDark', !isDark);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
            tooltip: 'Переключить тему',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/calculator'),
                icon: const Icon(Icons.calculate),
                label: const Text('Калькулятор'),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.go('/converter'),
                icon: const Icon(Icons.currency_exchange),
                label: const Text('Конвертер валют'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

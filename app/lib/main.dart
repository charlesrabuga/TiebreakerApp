import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';

void main() => runApp(const PiliPinoApp());

class PiliPinoApp extends StatefulWidget {
  const PiliPinoApp({super.key});

  @override
  State<PiliPinoApp> createState() => _PiliPinoAppState();
}

class _PiliPinoAppState extends State<PiliPinoApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pili-Pino',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: HomeScreen(onThemeToggle: _toggleTheme),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/game_state.dart';
import 'screens/home_screen.dart';
import 'screens/game_screen.dart';
import 'screens/game_setup_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/game_history_screen.dart';
import 'screens/help_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        title: 'Chess Master',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.brown,
            brightness: Brightness.light,
          ),
        ),
        home: const HomeScreen(),
        routes: {
          '/': (context) => const HomeScreen(),
          '/game': (context) => const GameScreen(),
          '/game_setup': (context) => const GameSetupScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/game_history': (context) => const GameHistoryScreen(),
          '/help': (context) => const HelpScreen(),
        },
      ),
    );
  }
}

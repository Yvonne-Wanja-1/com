import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[900]!, Colors.brown[700]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.chess_pawn, size: 80, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                'Chess Master',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Play Chess Online',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 60),
              _buildMenuButton(context, 'Play vs Player', Icons.people, () {
                Navigator.pushNamed(context, '/game_setup');
              }),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'Play vs AI', Icons.smart_toy, () {
                Navigator.pushNamed(context, '/game_setup');
              }),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'Game History', Icons.history, () {
                Navigator.pushNamed(context, '/game_history');
              }),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'Settings', Icons.settings, () {
                Navigator.pushNamed(context, '/settings');
              }),
              const SizedBox(height: 20),
              _buildMenuButton(context, 'How to Play', Icons.help_outline, () {
                Navigator.pushNamed(context, '/help');
              }),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(fontSize: 12, color: Colors.white38),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[700],
          foregroundColor: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

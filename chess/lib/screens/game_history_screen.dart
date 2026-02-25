import 'package:flutter/material.dart';

class GameHistoryScreen extends StatelessWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample game history data
    final gameHistory = [
      {
        'date': '2026-02-25',
        'white': 'You',
        'black': 'AI',
        'result': 'Win',
        'moves': 32,
        'time': '12 min',
      },
      {
        'date': '2026-02-24',
        'white': 'You',
        'black': 'Player 2',
        'result': 'Loss',
        'moves': 28,
        'time': '8 min',
      },
      {
        'date': '2026-02-24',
        'white': 'Player 1',
        'black': 'You',
        'result': 'Draw',
        'moves': 45,
        'time': '25 min',
      },
      {
        'date': '2026-02-23',
        'white': 'You',
        'black': 'AI',
        'result': 'Win',
        'moves': 38,
        'time': '15 min',
      },
      {
        'date': '2026-02-23',
        'white': 'You',
        'black': 'Player 3',
        'result': 'Win',
        'moves': 22,
        'time': '7 min',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
        backgroundColor: Colors.brown[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[100]!, Colors.brown[50]!],
          ),
        ),
        child: gameHistory.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No games played yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: gameHistory.length,
                itemBuilder: (context, index) {
                  final game = gameHistory[index];
                  return _buildGameHistoryCard(context, game, index);
                },
              ),
      ),
    );
  }

  Widget _buildGameHistoryCard(BuildContext context, Map game, int index) {
    final resultColor = game['result'] == 'Win'
        ? Colors.green
        : game['result'] == 'Loss'
        ? Colors.red
        : Colors.blue;

    return GestureDetector(
      onTap: () {
        _showGameDetails(context, game);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${game['white']} vs ${game['black']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        game['date'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: resultColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    game['result'] as String,
                    style: TextStyle(
                      color: resultColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildGameStat('Moves', game['moves'].toString()),
                _buildGameStat('Time', game['time'].toString()),
                _buildGameStat('Index', '#${index + 1}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showGameDetails(BuildContext context, Map game) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Date', game['date'] as String),
              const SizedBox(height: 12),
              _buildDetailRow('White', game['white'] as String),
              const SizedBox(height: 12),
              _buildDetailRow('Black', game['black'] as String),
              const SizedBox(height: 12),
              _buildDetailRow('Result', game['result'] as String),
              const SizedBox(height: 12),
              _buildDetailRow('Moves', game['moves'].toString()),
              const SizedBox(height: 12),
              _buildDetailRow('Time', game['time'] as String),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Could replay game here
              },
              child: const Text('Replay'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}

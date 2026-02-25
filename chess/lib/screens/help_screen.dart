import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to Play'),
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection(
              'Objective',
              'The goal of chess is to checkmate your opponent\'s king. '
                  'This means putting the king in a position where it is under attack (in check) '
                  'and cannot escape capture.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              'The Board',
              'Chess is played on an 8x8 board with alternating light and dark squares. '
                  'Each player starts with 16 pieces: 1 king, 1 queen, 2 rooks, 2 bishops, '
                  '2 knights, and 8 pawns. White always moves first.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              'Piece Movements',
              'Each piece has its own way of moving:',
            ),
            _buildPieceMovement(
              'Pawn (♟)',
              'Moves forward one square, or two squares on its first move. '
                  'Captures diagonally forward one square.',
            ),
            _buildPieceMovement(
              'Knight (♞)',
              'Moves in an L-shape: two squares in one direction and one square perpendicular. '
                  'Can jump over other pieces.',
            ),
            _buildPieceMovement(
              'Bishop (♝)',
              'Moves diagonally any number of squares. Cannot jump over pieces.',
            ),
            _buildPieceMovement(
              'Rook (♜)',
              'Moves horizontally or vertically any number of squares. Cannot jump over pieces.',
            ),
            _buildPieceMovement(
              'Queen (♛)',
              'Moves horizontally, vertically, or diagonally any number of squares. '
                  'The most powerful piece.',
            ),
            _buildPieceMovement(
              'King (♚)',
              'Moves one square in any direction. The most important piece.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              'Special Moves',
              'Castling: A special move where both the king and rook move. '
                  'The king moves two squares toward the rook, and the rook jumps over to the other side.\n\n'
                  'En Passant: A special pawn capture that can occur when an opposing pawn moves '
                  'two squares forward from its starting position.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              'Check and Checkmate',
              'Check: When the king is under attack but can escape.\n\n'
                  'Checkmate: When the king is under attack and cannot escape. This ends the game.\n\n'
                  'Stalemate: When a player has no valid moves and is not in check. The game is a draw.',
            ),
            const SizedBox(height: 20),
            _buildSection(
              'Game Features',
              '• Undo moves to try different strategies\n'
                  '• View game history and statistics\n'
                  '• Customize board themes and settings\n'
                  '• Play against another player or AI\n'
                  '• Track captured pieces\n'
                  '• Move counter and game status',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.blue[700]),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Pro Tip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Always protect your pieces and control the center of the board. '
                    'Develop your pieces quickly and don\'t move the same piece multiple times '
                    'in the opening. Look several moves ahead!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildPieceMovement(String piece, String movement) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              piece,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              movement,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

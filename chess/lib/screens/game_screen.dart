import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/chess_piece.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chess Game'),
          backgroundColor: Colors.brown[800],
          actions: [
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                context.read<GameState>().undoLastMove();
              },
              tooltip: 'Undo Move',
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _showResetDialog(context);
              },
              tooltip: 'New Game',
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              tooltip: 'Home',
            ),
          ],
        ),
        body: Consumer<GameState>(
          builder: (context, gameState, _) {
            return Column(
              children: [
                _buildPlayerInfo(context, PieceColor.black),
                const SizedBox(height: 16),
                Expanded(
                  child: Center(child: _buildChessBoard(context, gameState)),
                ),
                const SizedBox(height: 16),
                _buildPlayerInfo(context, PieceColor.white),
                const SizedBox(height: 16),
                _buildGameStatus(gameState),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(BuildContext context, PieceColor color) {
    return Consumer<GameState>(
      builder: (context, gameState, _) {
        final isCurrentPlayer = gameState.currentPlayer == color;
        final capturedCount = color == PieceColor.white
            ? gameState.capturedWhitePieces
            : gameState.capturedBlackPieces;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCurrentPlayer ? Colors.amber[700] : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            border: isCurrentPlayer
                ? Border.all(color: Colors.amber[900]!, width: 2)
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    color == PieceColor.white ? Icons.person : Icons.person,
                    color: color == PieceColor.white
                        ? Colors.white
                        : Colors.black,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${color.name.toUpperCase()} PLAYER',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color == PieceColor.white
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      if (isCurrentPlayer)
                        Text(
                          'Your Turn',
                          style: TextStyle(
                            fontSize: 12,
                            color: color == PieceColor.white
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (capturedCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Captured: $capturedCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChessBoard(BuildContext context, GameState gameState) {
    const squareSize = 40.0;
    final boardWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(8, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (col) {
            final isWhiteSquare = (row + col) % 2 == 0;
            final piece = gameState.board.getPiece(row, col);
            final isSelected =
                gameState.selectedRow == row && gameState.selectedCol == col;
            final isValidMove = gameState.validMoves.any(
              (move) => move.toRow == row && move.toCol == col,
            );

            return GestureDetector(
              onTap: () {
                gameState.selectSquare(row, col);
              },
              child: Container(
                width: squareSize,
                height: squareSize,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.green[700]
                      : isValidMove
                      ? Colors.green[300]
                      : isWhiteSquare
                      ? Colors.amber[100]
                      : Colors.brown[700],
                  border: isSelected
                      ? Border.all(color: Colors.green, width: 2)
                      : null,
                ),
                child: piece != null
                    ? GestureDetector(
                        onTap: () {
                          gameState.selectSquare(row, col);
                        },
                        child: Center(
                          child: Text(
                            piece.symbol,
                            style: TextStyle(
                              fontSize: 28,
                              color: piece.color == PieceColor.white
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      )
                    : isValidMove
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            );
          }),
        );
      }),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: boardWidget,
      ),
    );
  }

  Widget _buildGameStatus(GameState gameState) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: gameState.gameOver ? Colors.red[100] : Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: gameState.gameOver ? Colors.red : Colors.blue,
        ),
      ),
      child: Column(
        children: [
          Text(
            gameState.gameStatus,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: gameState.gameOver ? Colors.red[700] : Colors.blue[700],
            ),
          ),
          if (gameState.moveHistory.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Moves: ${gameState.moveHistory.length}',
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              ),
            ),
          if (gameState.gameOver)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ElevatedButton.icon(
                onPressed: () {
                  gameState.resetGame();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('New Game'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit Game?'),
              content: const Text('Are you sure you want to exit this game?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Exit'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Game?'),
          content: const Text('Start a new game? Current game will be lost.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<GameState>().resetGame();
                Navigator.pop(context);
              },
              child: const Text('New Game'),
            ),
          ],
        );
      },
    );
  }
}

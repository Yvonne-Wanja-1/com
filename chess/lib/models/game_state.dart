import 'package:flutter/material.dart';
import 'chess_piece.dart';
import 'chess_board.dart';
import 'move.dart';

class GameState extends ChangeNotifier {
  late ChessBoard _board;
  PieceColor _currentPlayer = PieceColor.white;
  List<Move> _moveHistory = [];
  int? _selectedRow;
  int? _selectedCol;
  List<Move> _validMoves = [];
  String _gameStatus = 'White to move';
  bool _gameOver = false;
  String _gameResult = '';
  String _gameMode = 'pvp'; // 'pvp' or 'ai'
  int _capturedWhitePieces = 0;
  int _capturedBlackPieces = 0;

  GameState() {
    _board = ChessBoard();
  }

  ChessBoard get board => _board;
  PieceColor get currentPlayer => _currentPlayer;
  List<Move> get moveHistory => _moveHistory;
  int? get selectedRow => _selectedRow;
  int? get selectedCol => _selectedCol;
  List<Move> get validMoves => _validMoves;
  String get gameStatus => _gameStatus;
  bool get gameOver => _gameOver;
  String get gameResult => _gameResult;
  String get gameMode => _gameMode;
  int get capturedWhitePieces => _capturedWhitePieces;
  int get capturedBlackPieces => _capturedBlackPieces;

  void selectSquare(int row, int col) {
    final piece = _board.getPiece(row, col);

    if (_selectedRow != null && _selectedCol != null) {
      // Check if this is the selected square
      if (row == _selectedRow && col == _selectedCol) {
        _selectedRow = null;
        _selectedCol = null;
        _validMoves = [];
        notifyListeners();
        return;
      }

      // Check if this is a valid move
      final move = Move(
        fromRow: _selectedRow!,
        fromCol: _selectedCol!,
        toRow: row,
        toCol: col,
      );

      if (_validMoves.contains(move)) {
        makeMove(move);
        return;
      }
    }

    // Select new piece
    if (piece != null && piece.color == _currentPlayer) {
      _selectedRow = row;
      _selectedCol = col;
      _validMoves = _board.getValidMoves(row, col);
    } else {
      _selectedRow = null;
      _selectedCol = null;
      _validMoves = [];
    }

    notifyListeners();
  }

  void makeMove(Move move) {
    final capturedPiece = _board.getPiece(move.toRow, move.toCol);
    if (capturedPiece != null) {
      if (capturedPiece.color == PieceColor.white) {
        _capturedWhitePieces++;
      } else {
        _capturedBlackPieces++;
      }
    }

    _board.makeMove(move);
    _moveHistory.add(move);
    _currentPlayer = _currentPlayer == PieceColor.white
        ? PieceColor.black
        : PieceColor.white;
    _selectedRow = null;
    _selectedCol = null;
    _validMoves = [];
    _updateGameStatus();
    notifyListeners();
  }

  void _updateGameStatus() {
    if (_gameOver) {
      _gameStatus = _gameResult;
    } else {
      _gameStatus = '${_currentPlayer.name.toUpperCase()} to move';
    }
  }

  void resetGame() {
    _board.resetBoard();
    _currentPlayer = PieceColor.white;
    _moveHistory = [];
    _selectedRow = null;
    _selectedCol = null;
    _validMoves = [];
    _gameStatus = 'White to move';
    _gameOver = false;
    _gameResult = '';
    _capturedWhitePieces = 0;
    _capturedBlackPieces = 0;
    notifyListeners();
  }

  void setGameMode(String mode) {
    _gameMode = mode;
    notifyListeners();
  }

  void endGame(String result) {
    _gameOver = true;
    _gameResult = result;
    _updateGameStatus();
    notifyListeners();
  }

  void undoLastMove() {
    if (_moveHistory.isNotEmpty) {
      _moveHistory.removeLast();
      _board.resetBoard();
      for (var move in _moveHistory) {
        _board.makeMove(move);
      }
      _currentPlayer = _currentPlayer == PieceColor.white
          ? PieceColor.black
          : PieceColor.white;
      _selectedRow = null;
      _selectedCol = null;
      _validMoves = [];
      _updateGameStatus();
      notifyListeners();
    }
  }
}

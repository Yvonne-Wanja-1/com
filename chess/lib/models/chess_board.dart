import 'chess_piece.dart';
import 'move.dart';

class ChessBoard {
  static const int boardSize = 8;
  late List<List<ChessPiece?>> board;

  ChessBoard() {
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(
      boardSize,
      (row) => List.generate(boardSize, (col) => null),
    );

    // Set up black pieces
    board[0][0] = ChessPiece(type: PieceType.rook, color: PieceColor.black);
    board[0][1] = ChessPiece(type: PieceType.knight, color: PieceColor.black);
    board[0][2] = ChessPiece(type: PieceType.bishop, color: PieceColor.black);
    board[0][3] = ChessPiece(type: PieceType.queen, color: PieceColor.black);
    board[0][4] = ChessPiece(type: PieceType.king, color: PieceColor.black);
    board[0][5] = ChessPiece(type: PieceType.bishop, color: PieceColor.black);
    board[0][6] = ChessPiece(type: PieceType.knight, color: PieceColor.black);
    board[0][7] = ChessPiece(type: PieceType.rook, color: PieceColor.black);

    for (int col = 0; col < boardSize; col++) {
      board[1][col] = ChessPiece(type: PieceType.pawn, color: PieceColor.black);
    }

    // Set up white pieces
    for (int col = 0; col < boardSize; col++) {
      board[6][col] = ChessPiece(type: PieceType.pawn, color: PieceColor.white);
    }

    board[7][0] = ChessPiece(type: PieceType.rook, color: PieceColor.white);
    board[7][1] = ChessPiece(type: PieceType.knight, color: PieceColor.white);
    board[7][2] = ChessPiece(type: PieceType.bishop, color: PieceColor.white);
    board[7][3] = ChessPiece(type: PieceType.queen, color: PieceColor.white);
    board[7][4] = ChessPiece(type: PieceType.king, color: PieceColor.white);
    board[7][5] = ChessPiece(type: PieceType.bishop, color: PieceColor.white);
    board[7][6] = ChessPiece(type: PieceType.knight, color: PieceColor.white);
    board[7][7] = ChessPiece(type: PieceType.rook, color: PieceColor.white);
  }

  ChessPiece? getPiece(int row, int col) {
    if (isValidPosition(row, col)) {
      return board[row][col];
    }
    return null;
  }

  bool isValidPosition(int row, int col) {
    return row >= 0 && row < boardSize && col >= 0 && col < boardSize;
  }

  List<Move> getValidMoves(int row, int col) {
    final piece = getPiece(row, col);
    if (piece == null) return [];

    List<Move> moves = [];

    switch (piece.type) {
      case PieceType.pawn:
        moves = _getPawnMoves(row, col, piece.color);
        break;
      case PieceType.knight:
        moves = _getKnightMoves(row, col, piece.color);
        break;
      case PieceType.bishop:
        moves = _getBishopMoves(row, col, piece.color);
        break;
      case PieceType.rook:
        moves = _getRookMoves(row, col, piece.color);
        break;
      case PieceType.queen:
        moves = _getQueenMoves(row, col, piece.color);
        break;
      case PieceType.king:
        moves = _getKingMoves(row, col, piece.color);
        break;
    }

    return moves;
  }

  List<Move> _getPawnMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    int direction = color == PieceColor.white ? -1 : 1;
    int startRow = color == PieceColor.white ? 6 : 1;

    // Move forward one square
    int newRow = row + direction;
    if (isValidPosition(newRow, col) && board[newRow][col] == null) {
      moves.add(Move(fromRow: row, fromCol: col, toRow: newRow, toCol: col));

      // Move forward two squares from starting position
      if (row == startRow) {
        int newRow2 = row + 2 * direction;
        if (board[newRow2][col] == null) {
          moves.add(
            Move(fromRow: row, fromCol: col, toRow: newRow2, toCol: col),
          );
        }
      }
    }

    // Capture diagonally
    for (int colOffset in [-1, 1]) {
      int newCol = col + colOffset;
      if (isValidPosition(newRow, newCol)) {
        final capturedPiece = board[newRow][newCol];
        if (capturedPiece != null && capturedPiece.color != color) {
          moves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              isCapture: true,
            ),
          );
        }
      }
    }

    return moves;
  }

  List<Move> _getKnightMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    const knightOffsets = [
      (-2, -1),
      (-2, 1),
      (-1, -2),
      (-1, 2),
      (1, -2),
      (1, 2),
      (2, -1),
      (2, 1),
    ];

    for (var (rowOffset, colOffset) in knightOffsets) {
      int newRow = row + rowOffset;
      int newCol = col + colOffset;

      if (isValidPosition(newRow, newCol)) {
        final piece = board[newRow][newCol];
        if (piece == null || piece.color != color) {
          moves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              isCapture: piece != null,
            ),
          );
        }
      }
    }

    return moves;
  }

  List<Move> _getBishopMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    const directions = [(-1, -1), (-1, 1), (1, -1), (1, 1)];

    for (var (rowDir, colDir) in directions) {
      int newRow = row + rowDir;
      int newCol = col + colDir;

      while (isValidPosition(newRow, newCol)) {
        final piece = board[newRow][newCol];
        if (piece == null) {
          moves.add(
            Move(fromRow: row, fromCol: col, toRow: newRow, toCol: newCol),
          );
        } else if (piece.color != color) {
          moves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              isCapture: true,
            ),
          );
          break;
        } else {
          break;
        }

        newRow += rowDir;
        newCol += colDir;
      }
    }

    return moves;
  }

  List<Move> _getRookMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    const directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

    for (var (rowDir, colDir) in directions) {
      int newRow = row + rowDir;
      int newCol = col + colDir;

      while (isValidPosition(newRow, newCol)) {
        final piece = board[newRow][newCol];
        if (piece == null) {
          moves.add(
            Move(fromRow: row, fromCol: col, toRow: newRow, toCol: newCol),
          );
        } else if (piece.color != color) {
          moves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              isCapture: true,
            ),
          );
          break;
        } else {
          break;
        }

        newRow += rowDir;
        newCol += colDir;
      }
    }

    return moves;
  }

  List<Move> _getQueenMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    moves.addAll(_getBishopMoves(row, col, color));
    moves.addAll(_getRookMoves(row, col, color));
    return moves;
  }

  List<Move> _getKingMoves(int row, int col, PieceColor color) {
    List<Move> moves = [];
    const directions = [
      (-1, -1),
      (-1, 0),
      (-1, 1),
      (0, -1),
      (0, 1),
      (1, -1),
      (1, 0),
      (1, 1),
    ];

    for (var (rowDir, colDir) in directions) {
      int newRow = row + rowDir;
      int newCol = col + colDir;

      if (isValidPosition(newRow, newCol)) {
        final piece = board[newRow][newCol];
        if (piece == null || piece.color != color) {
          moves.add(
            Move(
              fromRow: row,
              fromCol: col,
              toRow: newRow,
              toCol: newCol,
              isCapture: piece != null,
            ),
          );
        }
      }
    }

    return moves;
  }

  void makeMove(Move move) {
    final piece = board[move.fromRow][move.fromCol];
    board[move.toRow][move.toCol] = piece;
    board[move.fromRow][move.fromCol] = null;
  }

  void resetBoard() {
    initializeBoard();
  }
}

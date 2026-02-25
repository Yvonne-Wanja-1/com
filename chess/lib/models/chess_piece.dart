enum PieceType { pawn, knight, bishop, rook, queen, king }

enum PieceColor { white, black }

class ChessPiece {
  final PieceType type;
  final PieceColor color;

  ChessPiece({required this.type, required this.color});

  String get symbol {
    switch (type) {
      case PieceType.pawn:
        return '♟';
      case PieceType.knight:
        return '♞';
      case PieceType.bishop:
        return '♝';
      case PieceType.rook:
        return '♜';
      case PieceType.queen:
        return '♛';
      case PieceType.king:
        return '♚';
    }
  }

  String get displayName {
    switch (type) {
      case PieceType.pawn:
        return 'Pawn';
      case PieceType.knight:
        return 'Knight';
      case PieceType.bishop:
        return 'Bishop';
      case PieceType.rook:
        return 'Rook';
      case PieceType.queen:
        return 'Queen';
      case PieceType.king:
        return 'King';
    }
  }

  @override
  String toString() => '$displayName (${color.name})';
}

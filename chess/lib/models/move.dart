class Move {
  final int fromRow;
  final int fromCol;
  final int toRow;
  final int toCol;
  final bool isCapture;
  final bool isCastling;
  final bool isEnPassant;

  Move({
    required this.fromRow,
    required this.fromCol,
    required this.toRow,
    required this.toCol,
    this.isCapture = false,
    this.isCastling = false,
    this.isEnPassant = false,
  });

  @override
  String toString() =>
      'Move: ($fromRow, $fromCol) -> ($toRow, $toCol) ${isCapture ? '(capture)' : ''}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Move &&
          runtimeType == other.runtimeType &&
          fromRow == other.fromRow &&
          fromCol == other.fromCol &&
          toRow == other.toRow &&
          toCol == other.toCol;

  @override
  int get hashCode =>
      fromRow.hashCode ^ fromCol.hashCode ^ toRow.hashCode ^ toCol.hashCode;
}

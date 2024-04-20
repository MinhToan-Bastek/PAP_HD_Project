class StatusSummary {
  final int total;
  final int confirmed;
  final int temporaryConfirmed;
  final int rejected;
  final int awaitingConfirmation;

  StatusSummary({
    required this.total,
    required this.confirmed,
    required this.temporaryConfirmed,
    required this.rejected,
    required this.awaitingConfirmation,
  });

  factory StatusSummary.fromJson(Map<String, dynamic> json) {
    return StatusSummary(
      total: json['TongCong'] ?? 0,
      confirmed: json['XacNhan'] ?? 0,
      temporaryConfirmed: json['XacNhanTamThoi'] ?? 0,
      rejected: json['TuChoi'] ?? 0,
      awaitingConfirmation: json['ChoXacNhan'] ?? 0,
    );
  }
}

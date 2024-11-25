class SavedTransaction {
  String id;
  String title;
  double amount;
  DateTime savedAt;

  SavedTransaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.savedAt,
  });

  factory SavedTransaction.fromJson(Map<String, dynamic> json) {
    return SavedTransaction(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      savedAt: DateTime.parse(json['saved_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'saved_at': savedAt.toIso8601String(),
    };
  }
}

class TransactionLog {
  String id;
  String description;
  double amount;
  DateTime timestamp;
  String type;

  TransactionLog({
    required this.id,
    required this.description,
    required this.amount,
    required this.timestamp,
    required this.type,
  });

  factory TransactionLog.fromJson(Map<String, dynamic> json) {
    return TransactionLog(
      id: json['id'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
    };
  }
}

class FundsTransfer {
  late String? id;
  final String from;
  final String to;
  final double amount;
  final String date;
  final String type = 'FundsTransfer';

  FundsTransfer({
    required this.id,
    required this.from,
    required this.to,
    required this.amount,
    required this.date,
  });

  factory FundsTransfer.fromJson(Map<String, dynamic> json) {
    return FundsTransfer(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      amount: json['amount'],
      date: json['date'],
    );
  }
}

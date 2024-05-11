class Transaction {
  late String? id;
  final String category;
  final String description;
  final String? typeOfExpense;
  final double amount;
  final DateTime date;
  final String type = 'Transaction';

  Transaction({
    required this.id,
    required this.category,
    required this.description,
    required this.typeOfExpense,
    required this.amount,
    required this.date,
  });
}

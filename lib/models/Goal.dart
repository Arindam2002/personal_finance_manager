class Goal {
  final String title;
  final double targetAmount;
  final DateTime targetTime;
  final bool isLongTerm;
  double? currentAmount;
  final double? monthlySavings;

  Goal({
    required this.title,
    required this.targetAmount,
    required this.targetTime,
    this.isLongTerm = false,
    this.currentAmount,
    this.monthlySavings,
  });
}
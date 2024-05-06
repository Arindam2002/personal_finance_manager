class Goal {
  late String id;
  final String title;
  final double targetAmount;
  final DateTime targetTime;
  final bool isLongTerm;
  double? currentAmount;
  final double? monthlySavings;
  late bool isCompleted;
  late DateTime? createdTime;  // TODO: When API is made, on adding a goal, this will be set on Server side

  Goal({
    required this.id,
    required this.title,
    required this.targetAmount,
    required this.targetTime,
    this.isLongTerm = false,
    this.currentAmount,
    this.monthlySavings,
    this.isCompleted = false,
    this.createdTime,
  });
}
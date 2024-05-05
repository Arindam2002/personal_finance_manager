// utilities.dart
import 'package:intl/intl.dart';

String formatAmount(double amount) {
  // Create a NumberFormat instance with 'en_US' locale
  final formatter = NumberFormat.currency(locale: 'en_US', symbol: '₹');

  // Use the format() method to format the amount
  String formattedAmount = formatter.format(amount);

  return formattedAmount;
}
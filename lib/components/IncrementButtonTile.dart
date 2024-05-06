import 'package:flutter/material.dart';
import 'package:personal_finance_manager/constants/constants.dart';

class IncrementButtonTile extends StatelessWidget {
  const IncrementButtonTile({
    super.key,
    required TextEditingController targetCurrentAmountController,
    required this.incrementAmount,
  }) : _targetCurrentAmountController = targetCurrentAmountController;

  final TextEditingController _targetCurrentAmountController;
  final int incrementAmount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            double currentAmount = double.tryParse(_targetCurrentAmountController.text) ?? 0.0;
            _targetCurrentAmountController.text = (currentAmount + incrementAmount).toString();
          },
          child: Container(
            width: 50,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: kGreyColor),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text('+$incrementAmount', style: TextStyle(color: kPrimaryTextColor.withOpacity(0.8), fontSize: 10),),
            ),
          ),
        ),
      ),
    );
  }
}

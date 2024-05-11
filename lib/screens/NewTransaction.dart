import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance_manager/components/CustomTextFormField.dart';
import 'package:personal_finance_manager/constants/constants.dart';
import 'package:personal_finance_manager/models/Transaction.dart';
import 'package:personal_finance_manager/providers/AccountProvider.dart';
import 'package:personal_finance_manager/providers/EventProvider.dart';
import 'package:provider/provider.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({
    super.key,
  });

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // Form controllers
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController(text: DateFormat.yMMMd().format(DateTime.now()));

  final _transactionFormKey = GlobalKey<FormState>();

  String selectedCategory = 'Other';
  DateTime dateOfTransaction = DateTime.now();
  String typeOfExpense = 'Need';

  // Function to show the category selection dialog
  void showCategorySelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.dark(),
          child: AlertDialog(
            title: const Text('Select a category'),
            content: SingleChildScrollView(
              child: Column(
                children: categories.entries.map((entry) {
                  return ListTile(
                    leading: Icon(entry.value),
                    title: Text(entry.key),
                    onTap: () {
                      setState(() {
                        selectedCategory = entry.key;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Transaction',
          style: TextStyle(color: kPrimaryTextColor),
        ),
        flexibleSpace: Container(
          decoration: kScaffoldDecoration,
        ),
        iconTheme: IconThemeData(color: kPrimaryTextColor),
      ),
      body: Container(
        decoration: kScaffoldDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Form(
                  key: _transactionFormKey,
                  child: ListView(
                    children: [
                      // DESCRIPTION
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton.outlined(
                            onPressed: showCategorySelectionDialog,
                            icon: Icon(categories[selectedCategory]),
                            iconSize: 24,
                            color: Colors.white,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: kGreyColor,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              formController: _descriptionController,
                              labelText: 'Description',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      // TYPE (NEED / WANT)
                      if (selectedCategory != 'Income')
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton.outlined(
                                  onPressed: () {},
                                  icon: const Icon(Icons.category_rounded),
                                  iconSize: 24,
                                  color: Colors.white,
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color: kGreyColor,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Theme(
                                    data: ThemeData.dark(),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Type',
                                        labelStyle: TextStyle(color: kGreyColor),
                                        border: InputBorder.none,
                                        contentPadding: const EdgeInsets.all(10),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: kGreyColor),
                                        ),
                                      ),
                                      value: typeOfExpense,
                                      onChanged: (value) {
                                        typeOfExpense = value!;
                                      },
                                      items: ['Need', 'Want']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: kGreyColor, fontSize: 14),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      // AMOUNT
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton.outlined(
                            onPressed: () {},
                            icon: const Icon(Icons.currency_rupee_rounded),
                            iconSize: 24,
                            color: Colors.white,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: kGreyColor,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFormField(
                              formController: _amountController,
                              labelText: 'Amount',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid amount';
                                }
                                if (double.parse(value) > Provider.of<AccountProvider>(context, listen: false).currentBalance) {
                                  return 'Insufficient balance';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      // DATE
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton.outlined(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: dateOfTransaction,
                                firstDate: DateTime.now().subtract(Duration(days: 365)),
                                lastDate: DateTime.now(),
                              ).then((pickedDate) {
                                if (pickedDate == null) {
                                  return;
                                }
                                setState(() {
                                  dateOfTransaction = pickedDate;
                                  _dateController.text = DateFormat.yMMMd().format(pickedDate);
                                });
                              });
                            },
                            icon: const Icon(Icons.calendar_today_rounded),
                            iconSize: 24,
                            color: Colors.white,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(
                                color: kGreyColor,
                              ),
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              style: TextStyle(color: kGreyColor, fontSize: 14),
                              decoration: kFormFieldInputDecoration,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your code here to handle when the user taps on 'Add Transaction'
                  if (_transactionFormKey.currentState!.validate()) {
                    Transaction transaction = Transaction(
                      id: "",
                      category: selectedCategory,
                      description: _descriptionController.text,
                      typeOfExpense: typeOfExpense,
                      amount: double.parse(_amountController.text),
                      date: dateOfTransaction,
                    );
                    Provider.of<EventProvider>(context, listen: false).addTransaction(transaction);
                    _descriptionController.clear();
                    _amountController.clear();
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

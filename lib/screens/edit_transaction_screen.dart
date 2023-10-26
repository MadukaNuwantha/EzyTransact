// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ezytransact/constants.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:ezytransact/widgets/custom_date_field.dart';
import 'package:ezytransact/widgets/custom_dropdown_field.dart';
import 'package:ezytransact/widgets/custom_submit_button.dart';
import 'package:ezytransact/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTransactionScreen extends StatefulWidget {
  const EditTransactionScreen({super.key});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionService>(context, listen: false);
    numberController.text = transactionProvider.transaction.number.toString();
    amountController.text = transactionProvider.transaction.amount.toString();
    dateController.text = transactionProvider.transaction.date.toString();
    commissionController.text =
        transactionProvider.transaction.commission.toString();
    typeController.text = transactionProvider.transaction.type.toString();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: kDarkSecondaryColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Update Transaction',
                    style: TextStyle(
                      color: kDarkSecondaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: numberController,
                      labelText: 'Transaction Number',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: amountController,
                      labelText: 'Transaction Amount',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: commissionController,
                      labelText: 'Transaction Commission',
                    ),
                    const SizedBox(height: 10),
                    CustomDropdownField(
                      controller: typeController,
                      labelText: 'TransactionType',
                      itemList: [
                        'Deposit',
                        'Transfer',
                        'Withdrawal',
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomDateField(
                      controller: dateController,
                      labelText: 'Transaction Date',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomSubmitButton(
                title: 'Update',
                color: kPrimaryColor,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<TransactionService>(context, listen: false)
                        .updateTransaction(
                      context,
                      transactionProvider.transaction.id.toString(),
                      numberController.text,
                      amountController.text,
                      commissionController.text,
                      typeController.text,
                      dateController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ezytransact/constants.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:ezytransact/widgets/custom_date_field.dart';
import 'package:ezytransact/widgets/custom_dropdown_field.dart';
import 'package:ezytransact/widgets/custom_submit_button.dart';
import 'package:ezytransact/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                          'Create Transaction',
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
                            suffixIcon: Icons.percent,
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
                      title: 'Create',
                      color: kPrimaryColor,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          Provider.of<TransactionService>(context,
                                  listen: false)
                              .createTransaction(
                            context,
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
            ],
          ),
        ),
      ),
    );
  }
}

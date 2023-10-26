import 'package:ezytransact/constants.dart';
import 'package:ezytransact/dialogs/confirm_delete_dialog.dart';
import 'package:ezytransact/screens/edit_transaction_screen.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:ezytransact/widgets/transaction_view_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewTransactionScreen extends StatefulWidget {
  const ViewTransactionScreen({super.key});

  @override
  State<ViewTransactionScreen> createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  List<String> itemList = [
    'Edit',
    'Delete',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kVerticalPadding,
          ),
          child: Consumer<TransactionService>(
            builder: (context, transactionService, child) => Column(
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
                    Expanded(
                      child: Text(
                        'View Transaction',
                        style: TextStyle(
                          color: kDarkSecondaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  kTransactionImage,
                  width: 120,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Number',
                  value: transactionService.transaction.number.toString(),
                  icon: Icons.compare_arrows,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Type',
                  value: transactionService.transaction.type.toString(),
                  icon: Icons.money,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Amount',
                  value:
                      'LKR ${transactionService.transaction.amount.toString()}',
                  icon: Icons.attach_money,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Date',
                  value: transactionService.transaction.date.toString(),
                  icon: Icons.calendar_month,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Commission Percentage',
                  value: '${transactionService.transaction.commission} %',
                  icon: Icons.handshake_outlined,
                ),
                const SizedBox(height: 20),
                TransactionViewItemWidget(
                  title: 'Transaction Commission Value',
                  value: 'LKR ${double.parse(
                        transactionService.transaction.amount.toString(),
                      ) * double.parse(
                        transactionService.transaction.commission.toString(),
                      ) / 100}',
                  icon: Icons.handshake_outlined,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditTransactionScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: kLightSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ConfirmDeleteDialog(
                              id: transactionService.transaction.id.toString(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: kDarkAccentColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: kLightSecondaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ezytransact/constants.dart';
import 'package:ezytransact/models/transaction_model.dart';
import 'package:ezytransact/screens/view_transaction_screen.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionTileWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionTileWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<TransactionService>(context, listen: false).transaction =
            transaction;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewTransactionScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 1,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: kLightAccentColor,
              blurRadius: 2,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  kTransactionImage,
                  width: 60,
                ),
              ],
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.number.toString(),
                    style: TextStyle(
                      color: kDarkSecondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    transaction.type.toString(),
                    style: TextStyle(
                      color: kDarkSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'LKR ${transaction.amount}',
                    style: TextStyle(
                      color: kDarkAccentColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.date.toString(),
                  style: TextStyle(
                    color: kLightAccentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 45),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

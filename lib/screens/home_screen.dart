import 'package:ezytransact/constants.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:ezytransact/size_config.dart';
import 'package:ezytransact/widgets/transaction_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionService>(
      builder: (context, transactionService, child) {
        transactionService.getTransactions(context);
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Transactions',
                  style: TextStyle(
                    color: kDarkAccentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  transactionService.transactionList.length.toString(),
                  style: TextStyle(
                    color: kLightAccentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            transactionService.transactionList.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: SizeConfig.blockSizeVertical * 50),
                      Center(
                        child: Text(
                          'No transactions to display',
                          style: TextStyle(
                            color: kDarkAccentColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactionService.transactionList.length,
                    itemBuilder: (context, index) => TransactionTileWidget(
                      transaction: transactionService.transactionList[index],
                    ),
                  ),
          ],
        );
      },
    );
  }
}

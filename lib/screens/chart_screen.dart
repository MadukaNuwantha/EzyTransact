import 'package:ezytransact/constants.dart';
import 'package:ezytransact/services/transaction_service.dart';
import 'package:ezytransact/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Map<String, double> sale = {
    "Replenishment (10)": 10,
    "Transfer (50)": 50,
    "Withdrawal (40)": 40,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionService>(
      builder: (context, transactionService, child) {
        sale = {
          "Replenishment : LKR ${transactionService.valueOfDepositTransactions}":
              transactionService.valueOfDepositTransactions,
          "Transfer : LKR ${transactionService.valueOfTransferTransactions}":
              transactionService.valueOfTransferTransactions,
          "Withdrawal : LKR ${transactionService.valueOfWithdrawalTransactions}":
              transactionService.valueOfWithdrawalTransactions,
        };
        return Column(
          children: [
            Text(
              'Transaction Analytics',
              style: TextStyle(
                color: kDarkAccentColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 8),
            PieChart(
              dataMap: sale,
              animationDuration: const Duration(seconds: 3),
              chartLegendSpacing: 50,
              chartRadius: SizeConfig.blockSizeHorizontal * 80,
              colorList: [
                kPrimaryColor,
                kDarkAccentColor,
                kLightAccentColor,
              ],
              initialAngleInDegree: 0,
              chartType: ChartType.disc,
              ringStrokeWidth: 10,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontSize: 15,
                  color: kDarkAccentColor,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                chartValueStyle: TextStyle(
                  color: kDarkSecondaryColor,
                  fontSize: 20,
                ),
                chartValueBackgroundColor: Colors.white70,
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 2,
              ),
            )
          ],
        );
      },
    );
  }
}

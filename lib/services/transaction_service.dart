import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezytransact/models/transaction_model.dart';
import 'package:ezytransact/screens/dashboard_screen.dart';
import 'package:ezytransact/widgets/snack_bars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionService extends ChangeNotifier {
  TransactionModel transaction = TransactionModel();
  List<TransactionModel> transactionList = [];

  double depositTransactionPercentage = 0;
  double transferTransactionPercentage = 0;
  double withdrawalTransactionPercentage = 0;

  double noOfDepositTransactions = 0;
  double noOfTransferTransactions = 0;
  double noOfWithdrawalTransactions = 0;

  double valueOfDepositTransactions = 0;
  double valueOfTransferTransactions = 0;
  double valueOfWithdrawalTransactions = 0;

  double totalNoOfTransactions = 0;
  double totalValueOfTransactions = 0;

  //   instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //   instance for firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // create transaction
  Future<void> createTransaction(
    BuildContext context,
    String number,
    String amount,
    String commission,
    String type,
    String date,
  ) async {
    try {
      TransactionModel newTransaction = TransactionModel(
        number: number,
        amount: amount,
        commission: commission,
        type: type,
        date: date,
        timestamp: Timestamp.now(),
      );
      await _firebaseFirestore
          .collection('transactions')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('transactions')
          .add(newTransaction.toJson())
          .then(
        (docRef) async {
          TransactionModel storedTransaction = TransactionModel(
            id: docRef.id,
            number: number,
            amount: amount,
            commission: commission,
            type: type,
            date: date,
            timestamp: Timestamp.now(),
          );
          await _firebaseFirestore
              .collection('transactions')
              .doc(_firebaseAuth.currentUser!.uid)
              .collection('transactions')
              .doc(docRef.id)
              .update(storedTransaction.toJson())
              .whenComplete(
            () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
                (route) => false,
              );
            },
          );
        },
      );
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Get transaction list
  Future<void> getTransactions(BuildContext context) async {
    try {
      final transactionSnapshots = _firebaseFirestore
          .collection("transactions")
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('transactions')
          .orderBy('timestamp', descending: true)
          .snapshots();

      transactionSnapshots.listen(
        (QuerySnapshot snapshot) {
          transactionList.clear();
          transactionList.addAll(
            snapshot.docs.map(
              (doc) {
                return TransactionModel.fromJson(
                  doc.data() as Map<String, dynamic>,
                );
              },
            ).toList(),
          );
          depositTransactionPercentage = 0;
          transferTransactionPercentage = 0;
          withdrawalTransactionPercentage = 0;

          noOfDepositTransactions = 0;
          noOfTransferTransactions = 0;
          noOfWithdrawalTransactions = 0;

          valueOfDepositTransactions = 0;
          valueOfTransferTransactions = 0;
          valueOfWithdrawalTransactions = 0;

          totalNoOfTransactions = 0;
          totalValueOfTransactions = 0;
          for (var i = 0; i < transactionList.length; i++) {
            totalValueOfTransactions = totalValueOfTransactions +
                double.parse(transactionList[i].amount.toString());
            if (transactionList[i].type.toString() == 'Deposit') {
              noOfDepositTransactions++;
              valueOfDepositTransactions = valueOfDepositTransactions +
                  double.parse(transactionList[i].amount.toString());
            } else if (transactionList[i].type.toString() == 'Transfer') {
              noOfTransferTransactions++;
              valueOfTransferTransactions = valueOfTransferTransactions +
                  double.parse(transactionList[i].amount.toString());
            }
            if (transactionList[i].type.toString() == 'Withdrawal') {
              noOfWithdrawalTransactions++;
              valueOfWithdrawalTransactions = valueOfWithdrawalTransactions +
                  double.parse(transactionList[i].amount.toString());
            }
            depositTransactionPercentage =
                totalValueOfTransactions / valueOfDepositTransactions;
            transferTransactionPercentage =
                totalValueOfTransactions / valueOfTransferTransactions;
            withdrawalTransactionPercentage =
                totalValueOfTransactions / valueOfWithdrawalTransactions;
          }
          notifyListeners();
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(e.toString()),
      );
    }
  }

// update transaction
  Future<void> updateTransaction(
    BuildContext context,
    String id,
    String number,
    String amount,
    String commission,
    String type,
    String date,
  ) async {
    try {
      TransactionModel updatedTransaction = TransactionModel(
        id: id,
        number: number,
        amount: amount,
        commission: commission,
        type: type,
        date: date,
        timestamp: Timestamp.now(),
      );
      await _firebaseFirestore
          .collection('transactions')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('transactions')
          .doc(id)
          .update(updatedTransaction.toJson())
          .whenComplete(
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
            (route) => false,
          );
        },
      );
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // delete transaction
  Future<void> deleteTransaction(
    BuildContext context,
    String id,
  ) async {
    try {
      await _firebaseFirestore
          .collection('transactions')
          .doc(_firebaseAuth.currentUser!.uid)
          .collection('transactions')
          .doc(id)
          .delete()
          .whenComplete(
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
            (route) => false,
          );
        },
      );
    }
    // catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}

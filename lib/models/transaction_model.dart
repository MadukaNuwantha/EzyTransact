import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  String? number;
  String? type;
  String? amount;
  String? commission;
  String? date;
  Timestamp? timestamp;

  TransactionModel({
    this.id,
    this.number,
    this.type,
    this.amount,
    this.commission,
    this.date,
    this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        number: json["number"],
        type: json["type"],
        amount: json["amount"],
        commission: json["commission"],
        date: json["date"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "type": type,
        "amount": amount,
        "commission": commission,
        "date": date,
        "timestamp": timestamp,
      };
}

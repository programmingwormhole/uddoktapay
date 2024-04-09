// To parse this JSON data, do
//
//     final requestResponse = requestResponseFromJson(jsonString);

import 'dart:convert';

RequestResponse requestResponseFromJson(String str) =>
    RequestResponse.fromJson(json.decode(str));

String requestResponseToJson(RequestResponse data) =>
    json.encode(data.toJson());

class RequestResponse {
  String? fullName;
  String? email;
  String? amount;
  String? fee;
  String? chargedAmount;
  String? invoiceId;
  String? paymentMethod;
  String? senderNumber;
  String? transactionId;
  DateTime? date;
  ResponseStatus? status;

  RequestResponse({
    this.fullName,
    this.email,
    this.amount,
    this.fee,
    this.chargedAmount,
    this.invoiceId,
    this.paymentMethod,
    this.senderNumber,
    this.transactionId,
    this.date,
    this.status,
  });

  factory RequestResponse.fromJson(Map<String, dynamic> json) =>
      RequestResponse(
        fullName: json["full_name"],
        email: json["email"],
        amount: json["amount"],
        fee: json["fee"],
        chargedAmount: json["charged_amount"],
        invoiceId: json["invoice_id"],
        paymentMethod: json["payment_method"],
        senderNumber: json["sender_number"],
        transactionId: json["transaction_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"] == 'COMPLETED'
            ? ResponseStatus.completed
            : json['status'] == '' || json['status'] == null
                ? ResponseStatus.pending
                : ResponseStatus.canceled,
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "amount": amount,
        "fee": fee,
        "charged_amount": chargedAmount,
        "invoice_id": invoiceId,
        "payment_method": paymentMethod,
        "sender_number": senderNumber,
        "transaction_id": transactionId,
        "date": date?.toIso8601String(),
        "status": status,
      };
}

enum ResponseStatus {
  completed,
  canceled,
  pending,
}

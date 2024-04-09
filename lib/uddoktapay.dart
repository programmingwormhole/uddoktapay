// ignore_for_file: use_build_context_synchronously

library uddoktapay;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/controllers/payment_controller.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/views/payment_screen.dart';
import '../core/services/api_services.dart';
import '../models/credentials.dart';

class UddoktaPay {
  static Future<RequestResponse> createPayment({
    required BuildContext context,
    required CustomerDetails customer,
    UddoktapayCredentials? credentials,
    required String amount,
  }) async {
    final controller = Get.put(PaymentController());

    final request = await ApiServices.createPaymentRequest(
      customer: customer,
      amount: amount,
      context: context,
    );

    final String paymentURL = request['payment_url'];

    debugPrint(paymentURL);

    // Extract the payment ID from the last segment of the path
    String paymentId = Uri.parse(paymentURL).pathSegments.last;
    controller.paymentID.value = paymentId;

    debugPrint(controller.paymentID.value);

    final body = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          paymentURL: request['payment_url'],
        ),
      ),
    );

    if (body != null) {
      final response = body as RequestResponse;
      return response;
    }

    return RequestResponse(
      status: ResponseStatus.canceled,
    );
  }
}

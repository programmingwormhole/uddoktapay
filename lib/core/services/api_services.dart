// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uddoktapay/controllers/payment_controller.dart';
import 'package:uddoktapay/models/customer_model.dart';
import 'package:uddoktapay/models/request_response.dart';
import 'package:uddoktapay/utils/config.dart';
import 'package:uddoktapay/utils/endpoints.dart';
import 'package:uddoktapay/widget/custom_snackbar.dart';
import '../../models/credentials.dart';

class ApiServices {
  static Future<Map<String, dynamic>> createPaymentRequest({
    UddoktapayCredentials? uddoktapayCredentials,
    required CustomerDetails customer,
    required String amount,
    Map? metadata,
    String? webhookUrl,
    required BuildContext context,
  }) async {
    final Map<String, dynamic> requestData = {
      'full_name': customer.fullName,
      'email': customer.email,
      'amount': amount,
      'metadata': metadata ?? {"order_id": "10", "product_id": "5"},
      'redirect_url': AppConfig.redirectURL,
      'cancel_url': AppConfig.cancelURL,
      'return_type': 'GET',
      if (webhookUrl != null) 'webhook_url': webhookUrl,
    };

    final controller = Get.put(PaymentController());

    if (uddoktapayCredentials == null) {
      controller.panelURL.value = AppConfig.sandboxURL;
      controller.apiKey.value = AppConfig.sandboxAPIKey;
    } else {
      controller.panelURL.value = uddoktapayCredentials.panelURL;
      controller.apiKey.value = uddoktapayCredentials.apiKey;
    }

    try {
      final http.Response response = await http.post(
        Uri.parse(
          uddoktapayCredentials == null
              ? AppConfig.sandboxURL + Endpoints.createPayment
              : '${uddoktapayCredentials.panelURL}${Endpoints.createPayment}',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'RT-UDDOKTAPAY-API-KEY': uddoktapayCredentials == null
              ? AppConfig.sandboxAPIKey
              : uddoktapayCredentials.apiKey,
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        return {
          'status': responseData['status'],
          'message': responseData['message'],
          'payment_url': responseData['payment_url'],
        };
      } else {
        final error = jsonDecode(response.body)['message'];
        snackBar(error, context);
        debugPrint(error);
        throw Exception(error);
      }
    } catch (error) {
      snackBar('Something is wrong', context);
      throw Exception('Something is wrong');
    }
  }

  static Future<RequestResponse> verifyPayment(
    String invoiceId,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      'invoice_id': invoiceId,
    };

    final controller = Get.put(PaymentController());

    final http.Response response = await http.post(
      Uri.parse(
        '${controller.panelURL.value}${Endpoints.verifyPayment}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'RT-UDDOKTAPAY-API-KEY': controller.apiKey.value,
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return requestResponseFromJson(response.body);
    } else {
      final decoded = jsonDecode(response.body);
      snackBar(decoded['message'], context);
      throw Exception(decoded['message']);
    }
  }
}

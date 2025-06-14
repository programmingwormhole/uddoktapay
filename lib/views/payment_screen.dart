// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uddoktapay/controllers/payment_controller.dart';
import 'package:uddoktapay/core/services/api_services.dart';
import 'package:uddoktapay/utils/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentURL;
  final String redirectURL;
  final String cancelURL;

  const PaymentScreen({
    super.key,
    required this.paymentURL,
    required this.redirectURL,
    required this.cancelURL,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _webViewController;
  final PaymentController controller = Get.put(PaymentController());

  @override
  void initState() {

    print('Redirect : ${widget.redirectURL}');
    print('Cancel : ${widget.cancelURL}');

    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {

            print('Request url is ${request.url}');

            final uri = Uri.parse(request.url);
            final invoiceID = uri.queryParameters['invoice_id'];
            final status = uri.queryParameters['status'];

            if (uri.path.contains(widget.redirectURL) || uri.host.contains(widget.redirectURL) || uri.path.contains('invoiceID')) {

              controller.isPaymentVerifying.value = true;

              Uri uri = Uri.parse(request.url);
              String invoiceId = uri.queryParameters['invoice_id'] ?? '';

              debugPrint('Invoice ID $invoiceId');

              final response =
                  await ApiServices.verifyPayment(invoiceId, context);

              controller.isPaymentVerifying.value = false;

              if (context.mounted) {
                Navigator.pop(context, response);
              }

              return NavigationDecision.prevent;
            }

            if (request.url.startsWith(widget.cancelURL)) {
              controller.isPaymentVerifying.value = false;

              if (context.mounted) {
                Navigator.pop(context);
              }

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: WebViewWidget(
                    controller: _webViewController,
                  ),
                ),
              ],
            ),
            if (controller.isPaymentVerifying.value) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.90),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

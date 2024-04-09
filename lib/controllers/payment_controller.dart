import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxString paymentID = RxString('');
  RxString panelURL = RxString('');
  RxString apiKey = RxString('');

  RxBool isPaymentVerifying = RxBool(false);
}
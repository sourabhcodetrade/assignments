import 'package:flutter/services.dart';

class MasterCardChannel {
  static const MethodChannel _channel = MethodChannel("masterCardChannel");

  Future<void> startPayment({
    required final String merchantId,
    required final String merchantName,
    required final String merchantUrl,
  }) async {
    try {
      final result = await _channel.invokeMethod("startPayment", {
        "merchantId": merchantId,
        "merchantName": merchantName,
        "merchantUrl": merchantUrl,
      });
      print(result);
    } catch (e) {
      print(e);
    }
  }

  Future<void> authenticate(final String transactionId) async {
    try {
      final result =
          await _channel.invokeMethod("authenticate", {"txnId": transactionId});
      print(result);
    } catch (e) {
      print(e);
    }
  }
}

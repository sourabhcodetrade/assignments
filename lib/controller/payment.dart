import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future createPaymentIntent({
  required String name,
  required String address,
  required String pin,
  required String city,
  required String state,
  required String country,
  required String currency,
  required String amount,
}) async {
  try {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey = dotenv.env["STRIPE_SECRET_KEY"]!;
    final body = {
      'amount': amount,
      'currency': currency.toLowerCase(),
      'description': 'Flutter Testing',
      'shipping[name]': name,
      'shipping[address][line1]': address,
      'shipping[address][city]': city,
      'shipping[address][state]': state,
      'shipping[address][country]': country,
      'shipping[address][postal_code]': pin,
      'payment_method_types[]': 'card',
    };

    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json;
    } else {
      debugPrint("Error in Creating a payment Intent");
    }
  } catch (e) {
    debugPrint('Error = ${e.toString()}');
  }
}

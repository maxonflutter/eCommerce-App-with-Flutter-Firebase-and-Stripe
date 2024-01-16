import 'dart:convert';

import 'package:http/http.dart' as http;

// TODO: Add your Cloud Functions URLs here
const ENDPOINT_METHOD_ID_URL =
    "https://stripe-pay-endpoint-method-id-yln66foica-uc.a.run.app";

const ENDPOINT_INTENT_ID_URL =
    "https://stripe-pay-endpoint-intent-id-yln66foica-uc.a.run.app";

class PaymentClient {
  final http.Client client;

  PaymentClient({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> processPayment({
    required String paymentMethodId,
    required List<Map<String, dynamic>> items,
    String currency = 'eur',
    bool useStripeSdk = true,
  }) async {
    final url = Uri.parse(ENDPOINT_METHOD_ID_URL);
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'paymentMethodId': paymentMethodId,
        'items': items,
        'currency': currency,
        'useStripeSdk': useStripeSdk,
      }),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> confirmPayment({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(ENDPOINT_INTENT_ID_URL);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );

    return json.decode(response.body);
  }
}

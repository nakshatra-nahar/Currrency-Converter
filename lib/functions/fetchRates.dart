import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import '../models/ratesModel.dart';
import '../models/allCurrencies.dart';
import '../utils/key.dart';

Future<RatesModel> fetchRates() async {
  String uri =
      'https://openexchangerates.org/api/latest.json?app_id=${ApiKey.Key}';
  var response = await http.get(Uri.parse(uri));
  final result = ratesModelFromJson(response.body);
  return result;
}

Future<Map> getAllCurrenciesFun() async {
  String uri = 'https://openexchangerates.org/api/currencies.json';
  var response = await http.get(Uri.parse(uri));
  final result = allCurrenciesFromJson(response.body);
  return result;
}

String convertusd(Map exchangeRates, String usd, String currency) {
  String output =
      ((exchangeRates[currency] * double.parse(usd)).toStringAsFixed(2))
          .toString();
  return output;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  print(exchangeRates);
  String output = (double.parse(amount) /
          exchangeRates[currencybase] *
          exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}

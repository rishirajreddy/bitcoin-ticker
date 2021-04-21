import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';

const List<String> currencyList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey = '';
const coinapiURl = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  var context;
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrice = {};
    for (String crypto in cryptoList) {
      var uri =
          Uri.parse('$coinapiURl/$crypto/$selectedCurrency?apikey=$apiKey');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = response.body;
        var decodedData = jsonDecode(data);
        double price = decodedData['rate'];
        cryptoPrice[crypto] = price.toStringAsFixed(0);
      } else if (response.statusCode == 429) {
        print(response.statusCode);
        throw 'Requests exceeds the limit.Please try again after some time.';
      } else {
        print(response.statusCode);
        throw 'Problem with the get request.';
      }
    }
    return cryptoPrice;
  }
}

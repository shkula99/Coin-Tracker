import 'dart:convert';

import 'package:coin_tracker/constants.dart';
import 'package:coin_tracker/models/coin_model.dart';
import 'package:http/http.dart' as http;


const List<String> currenciesList = [
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
  'BTC/Bitcoin',
  'ETH/Ethereum',
  'LTC/Litecoin',
];

class CoinData {

  Future<List<CoinModel>> getCoinData(String currency) async {
    List<CoinModel> cryptoPrices = [];
    for (var crypto in cryptoList) {
      String coin = crypto.split('/')[0];
      String url = '$kBaseURL/$coin/$currency?apikey=$kAPIKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data);
        double price = data['rate'];
        String coinName = crypto.split('/')[1];
        CoinModel coinModel = CoinModel(
          icon: coin,
          name: coinName,
          price: price,
        );
        cryptoPrices.add(coinModel);
      } else {
        print('Failed to load data for $crypto. Status code: ${response.statusCode}');
      }
    }
      return cryptoPrices.isEmpty ? [] : cryptoPrices;
    }
  }



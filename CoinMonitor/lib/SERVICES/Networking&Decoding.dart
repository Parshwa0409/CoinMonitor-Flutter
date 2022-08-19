// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unused_local_variable, curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../CoinDataModel.dart';

class CoinListNetworkHelper {
  String? responseBody;

  List<CoinData> coinDataList = [];

  Future<dynamic> dataFetch(String currencySelected) async {
    String uri =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currencySelected&ids=&order=market_cap_desc&per_page=100&page=1&sparkline=false';

    var url = Uri.parse(uri);

    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        responseBody = response.body;
      }
      //try calling decodeHere and reduce the line in loadingScreen
      else {
        responseBody = null;
        throw Exception('Response\'s status code not equal to 200 !!!');
      }
      return responseBody;
    } catch (e) {
      print(e);
    }
  }

  void dataDecode() {
    try {
      if (responseBody != null) {
        List<dynamic> decodedData = jsonDecode(responseBody!);

        for (var temp in decodedData) {
          CoinData tempCoin = CoinData();
          tempCoin.name = temp['name'];
          tempCoin.symbol = temp['symbol'];
          tempCoin.imageURL = temp['image'];
          tempCoin.currentPrice = temp['current_price'];
          tempCoin.marketRank = temp['market_cap_rank'];
          tempCoin.valueChange = temp['price_change_24h'];
          tempCoin.percentChange = temp['price_change_percentage_24h'];
          tempCoin.lastUpdated = temp['last_updated'];

          tempCoin.labelColor =
              tempCoin.valueChange < 0 ? Colors.red : Colors.green;

          coinDataList.add(tempCoin);
        }
      } else {
        throw Exception('Data received is \'null\' & it cannot be operated !');
      }
    } catch (e) {
      print(e);
    }
  }
}

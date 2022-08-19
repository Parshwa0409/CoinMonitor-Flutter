import 'dart:developer';

import 'package:flutter/material.dart';

class CoinData {
  late String name;
  late String symbol;
  late String imageURL;
  late int marketRank;
  var currentPrice;
  late double percentChange;
  late double valueChange;
  var lastUpdated;

  Color labelColor = Colors.white;

  void fromJSON(Map<String, dynamic> map) {
    name = map['name'];
    symbol = map['symbol'];
    imageURL = map['image'];
    currentPrice = map['current_price'];
    marketRank = map['market_cap_rank'];
    valueChange = map['price_change_24h'];
    percentChange = map['price_change_percentage_24h'];
    lastUpdated = map['last_updated'];
  }

  void display() {
    log(name);
  }
}

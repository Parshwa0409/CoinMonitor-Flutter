import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.URL});

  final String URL;

  //get api responses
  Future<dynamic> gatCoinData() async {
    String responseBody = '';
    try {
      http.Response response = await http.get(Uri.parse(URL));
      if (response.statusCode == 200) {
        responseBody = response.body;
      } else {
        throw Exception('Response Status Code != 200 ${response.statusCode}');
      }
      return jsonDecode(responseBody);
    } catch (e) {
      log(e.toString());
    }
  }
}

List jsonResponseExample = [
  {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image":
        "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 24231,
    "market_cap": 463333917078,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 508897683432,
    "total_volume": 24991896898,
    "high_24h": 24245,
    "low_24h": 23674,
    "price_change_24h": 40.82,
    "price_change_percentage_24h": 0.16876,
    "market_cap_change_24h": 1539547966,
    "market_cap_change_percentage_24h": 0.33338,
    "circulating_supply": 19119781.0,
    "total_supply": 21000000.0,
    "max_supply": 21000000.0,
    "ath": 69045,
    "ath_change_percentage": -64.90216,
    "ath_date": "2021-11-10T14:24:11.849Z",
    "atl": 67.81,
    "atl_change_percentage": 35637.47293,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2022-08-12T19:49:11.611Z"
  }
];

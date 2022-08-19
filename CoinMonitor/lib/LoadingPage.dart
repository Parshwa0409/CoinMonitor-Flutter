// ignore_for_file: file_names, non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:coin_ticker/CoinMonitor.dart';
import 'package:coin_ticker/UTILITIES/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'SERVICES/NetworkHelper.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String coinTextField = 'Bitcoin';
  String currencySelected = 'USD';
  var decodedData;

  Future<void> initializeCoinMonitor() async {
    NetworkHelper networkHelper = NetworkHelper(
        URL:
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currencySelected&ids=${coinTextField.toLowerCase()}&order=market_cap_desc&per_page=100&page=1&sparkline=false');

    decodedData = await networkHelper.gatCoinData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CoinMonitor(decodedData: decodedData);
    }));
  }

  @override
  void initState() {
    super.initState();
    initializeCoinMonitor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'C O I N - M O N I T O R',
          style: kAppBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 8,
      ),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () => CoinMonitor(decodedData: decodedData),
            child: SpinKitDoubleBounce(
              color: Colors.grey[600],
              size: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}

// String currency = 'USD';
//
// var coinDataResponse;
//
// CoinListNetworkHelper operation = CoinListNetworkHelper();
// void fetch_decode() async {
//   await operation.dataFetch(currency);
//   operation.dataDecode();
//
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => CoinListingScreen(
//         coinDataList: operation.coinDataList,
//         currencySelected: currency,
//       ),
//     ),
//   );
// }

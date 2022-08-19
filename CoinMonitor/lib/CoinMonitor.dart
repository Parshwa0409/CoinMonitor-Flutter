import 'dart:developer';
import 'package:coin_ticker/CoinDataModel.dart';
import 'package:coin_ticker/SERVICES/NetworkHelper.dart';
import 'package:coin_ticker/UTILITIES/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CoinListingPage.dart';
import 'SERVICES/Networking&Decoding.dart';

class CoinMonitor extends StatefulWidget {
  CoinMonitor({Key? key, required this.decodedData}) : super(key: key);

  final dynamic decodedData;
  @override
  State<CoinMonitor> createState() => _CoinMonitorState();
}

class _CoinMonitorState extends State<CoinMonitor> {
  String coinTextField = 'Bitcoin';
  String currencySelected = 'USD';
  CoinData coinDataObj = CoinData();

  String? name;
  String? symbol;
  String? imageURL;
  var currentPrice;
  int? marketRank;
  double? priceChange;
  double? percentChange;
  String? lastUpdated;
  Color valueChangeColor = Colors.white;

  void decodeDataUpdateUI(dynamic decodedData) {
    try {
      //Data recieved is list and the jsonItem is the first item of list, so the decoded data we get from apiCAll is list and we use the decoded[0] item 1 to actually access the jsonData of coin we get.........
      //Example of data is present in coinDataModel.dart
      Map<String, dynamic> mapJSON = decodedData[0];

      coinDataObj.fromJSON(mapJSON);

      String tempStringValueChange = coinDataObj.valueChange.toStringAsFixed(6);
      String tempStringPercentChange =
          coinDataObj.percentChange.toStringAsFixed(4);

      Color tempColor = coinDataObj.valueChange < 0 ? Colors.red : Colors.green;
      setState(() {
        name = coinDataObj.name;
        symbol = coinDataObj.symbol;
        imageURL = coinDataObj.imageURL;
        currentPrice = coinDataObj.currentPrice;
        marketRank = coinDataObj.marketRank;
        priceChange = double.parse(tempStringValueChange);
        percentChange = double.parse(tempStringPercentChange);
        lastUpdated = coinDataObj.lastUpdated;
        valueChangeColor = tempColor;
      });
    } catch (e) {
      log(e.toString());
    }
    //data is completely decoded here all we do now is updateUI
  }

  Future<void> updateCoinMonitor() async {
    NetworkHelper networkHelper = NetworkHelper(
        URL:
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=$currencySelected&ids=${coinTextField.toLowerCase()}&order=market_cap_desc&per_page=100&page=1&sparkline=false');

    var decodedData = await networkHelper.gatCoinData();

    decodeDataUpdateUI(decodedData);
  }

  //initialing the data list , the coin data list so that when we move directly to that page its ready
  CoinListNetworkHelper CoinListObj = CoinListNetworkHelper();

  Future initializeCoinListData() async {
    await CoinListObj.dataFetch(currencySelected);
    CoinListObj.dataDecode();
  }

  //To initialize the DropDownItemList
  List<DropdownMenuItem<String>> addItemsToDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItemList = [];

    for (String currency in currenciesList) {
      var tempItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItemList.add(tempItem);
    }

    return dropDownItemList;
  }

  @override
  void initState() {
    super.initState();
    decodeDataUpdateUI(widget.decodedData);
    initializeCoinListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          '   C O I N - M O N I T O R',
          style: kAppBarTextStyle,
        ),
        // centerTitle: true,
        backgroundColor: Colors.grey[800],
        elevation: 8,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoinListingScreen(
                      coinDataList: CoinListObj.coinDataList,
                      currencySelected: currencySelected,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.list),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          BigCard(
            name: name ?? 'Bitcoin',
            symbol: symbol ?? 'BTC',
            imageURL: imageURL ??
                'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
            currentPrice: currentPrice,
            marketRank: marketRank ?? 0,
            priceChange: priceChange ?? 0.00,
            percentChange: percentChange ?? 0.00,
            lastUpdated: lastUpdated ?? '',
            valueChangeColor: valueChangeColor,
          ),
          //CryptoCurrency Title
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 0),
            child: Text(
              'Crypto Currency',
              style: kTextStyle22,
            ),
          ),

          //SearchBar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: kNeumorphicDecoration,
            child: TextField(
              showCursor: true,
              style: kSearchFieldTextStyle,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Bitcoin',
                hintStyle: kSearchFieldTextStyle,
                border: InputBorder.none,
              ),
              onChanged: (textFieldValue) {
                var finalValue = textFieldValue.replaceAll(' ', '-');
                if (finalValue.endsWith('-')) {
                  coinTextField =
                      finalValue.substring(0, finalValue.length - 1);
                } else {
                  coinTextField = finalValue;
                }
              },
            ),
          ),

          //CurrencyPicker
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: kNeumorphicDecoration,
            child: DropdownButton(
              style: kSearchFieldTextStyle,
              alignment: AlignmentDirectional.center,
              value: currencySelected,
              underline: DropdownButtonHideUnderline(child: Container()),
              onChanged: (currencyValue) {
                setState(() {
                  currencySelected = currencyValue as String;
                });
              },
              items: addItemsToDropdownButton(),
            ),
          ),

          //INKWELL FOR SPLASH FEEL  //Calculate Button
          InkWell(
            onTap: () {
              updateCoinMonitor();
              initializeCoinListData();
            },
            child: Ink(
              color: Colors.grey.shade800,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                margin:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                decoration: kNeumorphicDecoration,
                child: Text(
                  'CALCULATE',
                  textAlign: TextAlign.center,
                  style: kTextStyle22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  BigCard(
      {Key? key,
      required this.name,
      required this.symbol,
      required this.imageURL,
      required this.currentPrice,
      required this.marketRank,
      required this.priceChange,
      required this.percentChange,
      required this.lastUpdated,
      required this.valueChangeColor})
      : super(key: key);

  // final CoinData recievedCoinData;

  String name;
  String symbol;
  String imageURL;
  var currentPrice;
  int marketRank;
  double priceChange;
  double percentChange;
  String lastUpdated;
  Color valueChangeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: kNeumorphicDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Row - Column 2 Texts & Image
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.toUpperCase(),
                        style: kTextStyle18,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        symbol.toUpperCase(),
                        style: kTextStyle18,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 56,
                    width: 56,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(imageURL),
                    ),
                  )
                ],
              ),
              //Rank - 1
              const SizedBox(height: 20),
              Text('Rank - $marketRank', style: kTextStyle22),
              //Price - $23456
              const SizedBox(height: 16),
              Text('Price - $currentPrice', style: kTextStyle22),
              //Price Change in 24Hr -> row( value change & percent change)
              const SizedBox(height: 16),
              Text('Price Change - 24 H', style: kTextStyle22),
              //Last Updated
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$priceChange',
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        color: valueChangeColor,
                      ),
                    ),
                  ),
                  Text(
                    '$percentChange%',
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        color: valueChangeColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Last Updated', style: kTextStyle22),
              const SizedBox(height: 8),
              Text(lastUpdated, style: kTextStyle18),
            ],
          ),
        ],
      ),
    );
  }
}

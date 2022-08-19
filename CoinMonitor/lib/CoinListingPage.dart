import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:coin_ticker/UTILITIES/utilities.dart';
import 'CoinDataModel.dart';
import 'SERVICES/Networking&Decoding.dart';

class CoinListingScreen extends StatefulWidget {
  CoinListingScreen(
      {required this.coinDataList, required this.currencySelected});

  List<CoinData> coinDataList = [];
  String currencySelected;
  @override
  State<CoinListingScreen> createState() => _CoinListingScreenState();
}

class _CoinListingScreenState extends State<CoinListingScreen> {
  List<CryptoItem> cryptoWidgetList = [];

  void addItemsToCryptoList(List<CoinData> coinList) {
    List<CryptoItem> cryptoWidgetTempList = [];
    for (CoinData coin in coinList) {
      var temp = CryptoItem(
        coinObj: coin,
        currency: widget.currencySelected,
      );
      cryptoWidgetTempList.add(temp);
    }
    setState(() {
      cryptoWidgetList = cryptoWidgetTempList;
    });
  }

  Future<void> updateCoinList() async {
    CoinListNetworkHelper coinListObject = CoinListNetworkHelper();
    await coinListObject.dataFetch(widget.currencySelected);
    coinListObject.dataDecode();

    //operation is object of network & decode and we have created such that , all the operation are done and result are ready   in the class object to be used directly , so the dataList also present in the object as member
    //now all we do is update the list after refresh

    addItemsToCryptoList(coinListObject.coinDataList);
  }

  @override
  void initState() {
    super.initState();
    updateCoinList();
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
        child: LiquidPullToRefresh(
          color: Colors.grey.shade600,
          backgroundColor: Colors.grey.shade800,
          height: 125,
          onRefresh: updateCoinList,
          showChildOpacityTransition: true,
          animSpeedFactor: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              children: cryptoWidgetList,
            ),
          ),
        ),
      ),
    );
  }
}

class CryptoItem extends StatelessWidget {
  CryptoItem({required this.coinObj, required this.currency});
  final CoinData coinObj;
  final String currency;

  @override
  Widget build(BuildContext context) {
    String tempStringValue = coinObj.currentPrice!.toString();
    double currentValue = double.parse(tempStringValue);

    return Container(
      height: 90,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      decoration: kNeumorphicDecoration,
      child: Row(
        children: [
          Container(
            decoration: kNeumorphicDecoration,
            height: 60,
            width: 60,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.network(coinObj.imageURL),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coinObj.name,
                style: kTextStyle16,
              ),
              Text(
                '$currentValue $currency',
                style: kTextStyle16,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                coinObj.symbol.toUpperCase(),
                style: kTextStyle16,
              ),
              Text(
                '${coinObj.percentChange.toStringAsFixed(2)}%',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: coinObj.labelColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

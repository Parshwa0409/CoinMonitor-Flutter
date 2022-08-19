import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../UTILITIES/utilities.dart';

class GraphNetworking {
  GraphNetworking({required this.cryptoCurrency});

  String cryptoCurrency;
  List<FlSpot> flSpotValue = [];

  Future<dynamic> getPlotValues() async {
    String url =
        'https://api.coingecko.com/api/v3/coins/$cryptoCurrency/market_chart?vs_currency=usd&days=30&interval=daily';
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Bad Error Code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> decodeGraphData() async {
    var jsonFormatPrices = await getPlotValues();

    List prices = jsonFormatPrices['prices'];

    for (List item in prices) {
      log(item.toString());
      var tempSpot = FlSpot(item[0], item[1]);

      flSpotValue.add(tempSpot);
    }
  }
}

class GraphChart extends StatefulWidget {
  GraphChart({Key? key, required this.cryptoCurrency}) : super(key: key);

  String cryptoCurrency;

  @override
  State<GraphChart> createState() => _GraphChartState();
}

class _GraphChartState extends State<GraphChart> {
  List<FlSpot> finalSpotValues = [];

  void updateGraph() {
    GraphNetworking graphNetworking =
        GraphNetworking(cryptoCurrency: widget.cryptoCurrency);

    graphNetworking.decodeGraphData();

    setState(() {
      finalSpotValues = graphNetworking.flSpotValue;
    });
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
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height) / 3,
        width: (MediaQuery.of(context).size.width),
        padding: const EdgeInsets.all(48.0),
        margin: const EdgeInsets.all(24.0),
        decoration: kNeumorphicDecoration,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: finalSpotValues,
                isCurved: true,
                barWidth: 3,
                color: Colors.white,
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

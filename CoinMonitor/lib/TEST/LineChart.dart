import 'dart:convert';
import 'package:coin_ticker/UTILITIES/utilities.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  List<FlSpot> finalSpotValues = [];
  int? minXaxisValue;
  double? minYaxisValue;
  int? maxXaxisValue;
  double? maxYaxisValue;

  Future<dynamic> networkingGraphData() async {
    String url =
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30&interval=daily';
    //daily value for past 30 days

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Bad Error Code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> decodeGraphData() async {
    var jsonFormatPrices = await networkingGraphData();

    List<FlSpot> flSpotValue = [];
    List prices = jsonFormatPrices['prices'];

    for (List item in prices) {
      print(item);
      var tempSpot = FlSpot(item[0], item[1]);

      flSpotValue.add(tempSpot);
    }

    setState(() {
      // minXaxisValue = prices.first[0];
      // minYaxisValue = prices.first[1];
      // maxXaxisValue = prices.last[0];
      // maxYaxisValue = prices.last[1];
      finalSpotValues = flSpotValue;
    });
  }

  @override
  void initState() {
    super.initState();
    decodeGraphData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height) / 2.5,
      width: (MediaQuery.of(context).size.width),
      padding: const EdgeInsets.all(48.0),
      margin: const EdgeInsets.all(24.0),
      decoration: kNeumorphicDecoration,
      child: LineChart(
        LineChartData(
          // showingTooltipIndicators: ,
          // minX: minXaxisValue!.toDouble(),
          // maxX: maxXaxisValue!.toDouble(),
          // minY: minYaxisValue,
          // maxY: maxYaxisValue,

          gridData: FlGridData(show: false),
//to not show the grid lines , we can change the horizontal line and vertical line too , check out the video, it requires a method and a callBack which return FlLine widget with line property

          //setting border properties for graph section
          borderData: FlBorderData(show: false),

          //title data means x and y axis values titles etc»
          titlesData: FlTitlesData(
            show: false,
          ), // to disable all tiles in graph
          //we have LineBarData, which has LineBarChartData as child in the list
          lineBarsData: [
            LineChartBarData(
              //in spots we ive list of data as Flspot(x,y)
              spots: finalSpotValues,
              // lets make the graph curved
              isCurved: true,
              barWidth: 3,
              color: Colors.white,

              //showing dots or not showing it
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:coin_ticker/TEST/LineChart.dart';
import 'package:coin_ticker/UTILITIES/utilities.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageSlider extends StatelessWidget {
  const HomePageSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("C O I N - M O N I T O R"),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              Container(
                margin: const EdgeInsets.all(24),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                width: (MediaQuery.of(context).size.width),
                decoration: kNeumorphicDecoration,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BITCOIN',
                              style: kTextStyle22,
                            ),
                            Text(
                              'BTC',
                              style: kTextStyle22,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 64,
                          width: 64,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                                'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579'),
                          ),
                        )
                      ],
                    ),
                    //Rank - 1
                    const SizedBox(height: 16),
                    Text('Rank - 1', style: kTextStyle22),
                    //Price - $23456
                    const SizedBox(height: 16),
                    Text('Price - 2369 USD', style: kTextStyle22),
                    //Price Change in 24Hr -> row( value change & percent change)
                    const SizedBox(height: 16),
                    Text('Price Change - 12.678 USD', style: kTextStyle22),
                    //Last Updated
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('12.678', style: kTextStyle22Color),
                        Text('-4.69%', style: kTextStyle22Color),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Last Updated', style: kTextStyle22),
                    const SizedBox(height: 8),
                    Text('2022-08-06T10:15:33.766Z', style: kTextStyle16),
                  ],
                ),
              ),
              LineChartWidget(),
            ],

            //Slider Container properties
            options: CarouselOptions(
              enlargeCenterPage: false,
              aspectRatio: 1 / 1,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              // viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

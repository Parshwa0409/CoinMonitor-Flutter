import 'dart:developer';

import 'package:flutter/material.dart';

class CheckColor extends StatefulWidget {
  const CheckColor({Key? key}) : super(key: key);

  @override
  State<CheckColor> createState() => _CheckColorState();
}

class _CheckColorState extends State<CheckColor> {
  List containerIndexSelected = [false, false, false];
  List tipValues = [10, 12, 15];
  late int tipSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('CheckColor'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                log("Container 1");
                setState(() {
                  containerIndexSelected = [true, false, false];
                  tipSelected = tipValues[0];
                });
                log('Selected tip value = ${tipSelected.toString()}%');
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                color: containerIndexSelected[0] == true
                    ? Colors.grey
                    : Colors.lightBlue,
                height: 200,
                child: const Center(
                  child: Text('10%'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                log("Container 2");
                setState(() {
                  containerIndexSelected = [false, true, false];
                  tipSelected = tipValues[1];
                });
                log('Selected tip value = ${tipSelected.toString()}%');
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                color: containerIndexSelected[1] == true
                    ? Colors.grey
                    : Colors.lightBlue,
                height: 200,
                child: const Center(
                  child: Text('12%'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                log("Container 3");
                setState(() {
                  containerIndexSelected = [false, false, true];
                  tipSelected = tipValues[2];
                });
                log('Selected tip value = ${tipSelected.toString()}%');
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                color: containerIndexSelected[2] == true
                    ? Colors.grey
                    : Colors.lightBlue,
                height: 200,
                child: const Center(
                  child: Text('15%'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

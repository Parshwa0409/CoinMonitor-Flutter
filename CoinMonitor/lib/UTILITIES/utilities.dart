import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kAppBarTextStyle = GoogleFonts.notoSans(
    textStyle: const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18, letterSpacing: 1));

var kTextStyle18 = GoogleFonts.notoSans(
    textStyle: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 2));

var kTextStyle16 = GoogleFonts.notoSans(
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 2));

var kTextStyle20 = GoogleFonts.notoSans(
    textStyle: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 2));

var kTextStyle22 = GoogleFonts.notoSans(
    textStyle: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w400, letterSpacing: 2));

var kTextStyle22Color = GoogleFonts.notoSans(
    textStyle: const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  letterSpacing: 2,
  color: Colors.red,
));

var kSearchFieldTextStyle = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 2);

BoxDecoration kNeumorphicDecoration = BoxDecoration(
  boxShadow: [
    const BoxShadow(
        color: Colors.black,
        offset: Offset(3, 3),
        blurRadius: 15,
        spreadRadius: 1),
    BoxShadow(
        color: Colors.grey.shade700,
        offset: const Offset(-3, -3),
        blurRadius: 15,
        spreadRadius: 1),
  ],
  color: Colors.grey.shade800,
  borderRadius: const BorderRadius.all(
    Radius.circular(16),
  ),
);

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'INR',
  'JPY',
  'NZD',
  'PLN',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

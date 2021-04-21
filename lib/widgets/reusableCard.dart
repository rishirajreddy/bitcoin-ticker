import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/constants/constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.bitcoinValue, this.currency, this.cryptoCurrency});

  final String bitcoinValue;
  final String currency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(kcardColor),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Text(
          '1$cryptoCurrency = $bitcoinValue $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}

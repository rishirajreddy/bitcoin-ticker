import 'dart:ui';
import 'package:bitcoin_ticker/widgets/reusableCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coins.dart';
import 'constants/constants.dart';
import 'dart:io' show Platform;
import 'dart:async';
import 'package:rflutter_alert/rflutter_alert.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int selectedIndex = 1;
  String bitcoin = '?';

  CupertinoPicker cupertinoPicker() {
    List<Text> pickerItems = [];
    for (String currency in currencyList) {
      pickerItems.add(Text(currency,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'UbuntuMono',
          )));
    }

    return CupertinoPicker(
      backgroundColor: Color(kcardColor),
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        selectedCurrency = currencyList[value];
        Timer(Duration(seconds: 2), () {
          getData();
        });
      },
      children: pickerItems,
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currencyList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }

    return DropdownButton(
      icon: Icon(
        Icons.arrow_upward,
        color: Colors.white,
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'RobotoMono'),
      elevation: 16,
      dropdownColor: Color(0xFF6AD79E),
      underline: Container(
        height: 50,
      ),
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  Map<String, String> coinValue = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValue = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return cupertinoPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: Center(
            child: Text(
          'BitCoin Ticker',
          style:
              TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold),
        )),
        backgroundColor: Color(kbackgroundColor),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 0),
                child: ReusableCard(
                  cryptoCurrency: 'BTC',
                  currency: selectedCurrency,
                  bitcoinValue: isWaiting ? '?' : coinValue['BTC'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 0),
                child: ReusableCard(
                  cryptoCurrency: 'ETH',
                  currency: selectedCurrency,
                  bitcoinValue: isWaiting ? '?' : coinValue['ETH'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 0),
                child: ReusableCard(
                  cryptoCurrency: 'LTC',
                  currency: selectedCurrency,
                  bitcoinValue: isWaiting ? '?' : coinValue['LTC'],
                ),
              ),
            ],
          ),
          Column(children: [
            Container(
              height: 150.0,
              alignment: Alignment.center,
              color: Color(kappBarColor),
              child: cupertinoPicker(),
            ),
            Text(
              'Select Currency',
              style: TextStyle(color: Colors.white),
            ),
          ])
        ],
      )),
    );
  }
}

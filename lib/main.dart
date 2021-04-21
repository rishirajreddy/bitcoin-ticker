import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.white,
        primaryColor: Color(0xFF222840),
        scaffoldBackgroundColor: Color(0xFF26304B),
      ),
      home: PriceScreen(),
    );
  }
}

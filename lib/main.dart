import 'package:flutter/material.dart';
import 'package:prayer/page/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.orange[200],
        fontFamily: 'OpenSans',
      ),
      home: MainPage(),
    );
  }
}

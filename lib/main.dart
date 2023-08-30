import 'package:flutter/material.dart';
import 'package:kisahaber/pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kısa Haber',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const MainPage(),
    );
  }
}

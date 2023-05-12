import 'package:crypto4you/models/screens/help.dart';
import 'package:flutter/material.dart';

import 'models/screens/fistpage.dart';
import 'models/screens/spaleshscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'mr'),
        debugShowCheckedModeBanner: false,
        home: FirstPage());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_fetch_data/pages/index.dart';
import 'package:flutter_fetch_data/theme/color.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primary),
      home: IndexPage(),
    );
  }
}

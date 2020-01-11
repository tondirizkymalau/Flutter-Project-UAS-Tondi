import 'package:flutter/material.dart';
import 'package:spoonacular_app/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[500],
      ),
      home: SearchScreen(),
    );
  }
}
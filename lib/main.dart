import 'package:flutter/material.dart';
import 'home_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro_App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:mindblocks/MyStopwatchApp.dart';
import 'package:mindblocks/home_view.dart';
import 'package:mindblocks/homepage.dart';
import 'package:mindblocks/timerapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_performance/list/list.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MessageList()),
    );
  }
}

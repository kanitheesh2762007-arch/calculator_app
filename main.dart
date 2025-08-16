import 'package:flutter/material.dart';
import 'package:calculator_app/CalculatorApp.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CalculatorApp());
  }
}

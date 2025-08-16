import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String userInput = "";
  String result = "0";

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  void onButtonPressed(String button) {
    setState(() {
      if (button == "C") {
        userInput = "";
        result = "0";
      } else if (button == "DEL") {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (button == "=") {
        try {
          // Replace × with *
          String finalInput = userInput.replaceAll("×", "*");

          GrammarParser p = GrammarParser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();

          double eval = exp.evaluate(
            EvaluationType.REAL,
            cm,
          ); // still works (deprecated warning)
          result = eval.toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        userInput += button;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 30, 49),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Color.fromARGB(179, 16, 15, 15),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                final button = buttons[index];
                return GestureDetector(
                  onTap: () => onButtonPressed(button),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _isOperator(button)
                          ? const Color.fromARGB(255, 215, 151, 55)
                          : const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        button,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 15, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isOperator(String x) {
    return x == "%" || x == "/" || x == "×" || x == "-" || x == "+" || x == "=";
  }
}

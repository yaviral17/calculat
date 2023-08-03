import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String result = "0";
  String expression = "";

  double activeFontSize = 80;
  double passiveFontSize = 40;

  void calculate(String btnText) {
    if (btnText == 'C') {
      setState(() {
        result = "0";
        expression = "";
        activeFontSize = 80;
        passiveFontSize = 40;
      });
    } else if (btnText == '←') {
      setState(() {
        activeFontSize = 40;
        passiveFontSize = 80;
        if (expression == "") {
          result = "0";
        }
        expression = expression.substring(0, expression.length - 1);
      });
    } else if (btnText == "=") {
      setState(() {
        String temp = expression;
        temp = temp.replaceAll('×', '*');
        temp = temp.replaceAll('÷', '/');

        try {
          // ignore: unused_local_variable

          // ignore: unused_local_variable
          Expression exp = Parser().parse(temp.isEmpty ? "0" : temp);
          // ignore: unused_local_variable
          ContextModel cm = ContextModel();

          String temRes = '${exp.evaluate(EvaluationType.REAL, cm)}';
          activeFontSize = 80;
          passiveFontSize = 40;
          if (temRes.contains('e+')) {
            result = temRes;
            return;
          }
          List<String> temResList = temRes.split('.');
          log(temResList.toString());
          if (temResList[1] == '0') {
            result = temResList[0];
            return;
          }
        } catch (e) {
          activeFontSize = 80;
          passiveFontSize = 40;
          result = "Error";
        }
      });
    } else {
      setState(() {
        activeFontSize = 40;
        passiveFontSize = 80;
        if (expression == "0") {
          expression = btnText;
        } else {
          expression = expression + btnText;
        }
      });
    }
  }

  Widget _buildButton(String label, BuildContext context, Color bgColor) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        calculate(label);
      },
      child: Container(
        width: size.width > 390 ? 390 * (80 / 390) : size.width * (80 / 390),
        height: size.width > 390 ? 390 * (80 / 390) : size.width * (80 / 390),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: bgColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize:
                  size.width > 390 ? 390 * (44 / 390) : size.width * (44 / 390),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spacer(),
          Text(
            expression,
            style: TextStyle(
              fontSize: size.width * (passiveFontSize / 390),
              color: passiveFontSize > activeFontSize
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Expanded(
            child: Text(
              result,
              style: TextStyle(
                fontSize: result.length > size.width * (8 / 390)
                    ? size.width * (passiveFontSize / 390) -
                        (result.length / size.width * (8 / 390)).round() * 0.9
                    : size.width * (activeFontSize / 390) * (0.8),
                color: activeFontSize > passiveFontSize
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("C", context, Colors.grey.withOpacity(0.8)),
              _buildButton("←", context, Colors.grey.withOpacity(0.8)),
              _buildButton("%", context, Colors.grey.withOpacity(0.8)),
              _buildButton("÷", context, Color.fromARGB(255, 255, 163, 4)),
            ],
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("7", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("8", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("9", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("×", context, Color.fromARGB(255, 255, 163, 4)),
            ],
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("4", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("5", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("6", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("-", context, Color.fromARGB(255, 255, 163, 4)),
            ],
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("1", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("2", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("3", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("+", context, Color.fromARGB(255, 255, 163, 4)),
            ],
          ),
          SizedBox(
            height: size.height * (12 / 844),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  calculate("0");
                },
                child: Container(
                  width: size.width > 390
                      ? 390 * (80 * 2 / 390)
                      : size.width * (80 * 2 / 390),
                  height: size.width > 390
                      ? 390 * (80 / 390)
                      : size.width * (80 / 390),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width > 390
                            ? 390 * (36 / 390)
                            : size.width * (80 / 390) * (0.1),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                          fontSize: size.width > 390
                              ? 390 * (44 / 390)
                              : size.width * (44 / 390),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width > 390
                    ? 390 * (4 / 390)
                    : size.width * (80 / 390),
              ),
              _buildButton(".", context,
                  Color.fromARGB(255, 37, 37, 37).withOpacity(0.8)),
              _buildButton("=", context, Color.fromARGB(255, 255, 163, 4)),
            ],
          ),
        ],
      ),
    );
  }
}

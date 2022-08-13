import 'package:flutter/material.dart';
import 'package:flutter_calculator/data/constant.dart';
import 'package:math_expressions/math_expressions.dart';

class MainApplication extends StatefulWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainApplicationState();

}

class _MainApplicationState extends State<MainApplication> {
  String exp = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueGrey900,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: blueGrey900,
                ),
                child: _getTexts(),
              ),
            ),
            Expanded(
              flex: 70,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: blueGrey700,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    _getButton('C', 'DE', '(', ')'),
                    _getButton('7', '8', '9', '/'),
                    _getButton('4', '5', '6', 'x'),
                    _getButton('1', '2', '3', '+'),
                    _getButton('.', '0', '-', '='),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

  Widget _getTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          exp,
          style: TextStyle(color: white, fontSize: 24),
        ),
        const SizedBox(height: 10),
        Text(
          result,
          style: TextStyle(
            color: white, fontSize: 30, fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  Widget _getButton(String s, String t, String u, String v) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () => Calculate(s),
                style: TextButton.styleFrom(
                  backgroundColor: blueGrey900,
                  primary: getTextColor(s),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(s),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () => Calculate(t),
                style: TextButton.styleFrom(
                  backgroundColor: blueGrey900,
                  primary: getTextColor(t),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(t),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () => Calculate(u),
                style: TextButton.styleFrom(
                  backgroundColor: blueGrey900,
                  primary: getTextColor(u),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(u),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TextButton(
                onPressed: () => Calculate(v),
                style: TextButton.styleFrom(
                  backgroundColor: blueGrey900,
                  primary: getTextColor(v),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(v),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Calculate(String s) {
    setState(() {
      List<String> clearsResult = ['C', 'DE', '='];

      if (!clearsResult.contains(s) && result != '') {
        exp = result;
        result = '';
        exp += s;
      } else if (!clearsResult.contains(s)) {
        exp += s;
      } else if (s == 'DE') {
        exp = exp.substring(0, exp.length - 1);
      } else if (s == 'C') {
        exp = '';
        result = '';
      } else {
        Parser parser = Parser();
        Expression e = parser.parse(exp.replaceAll('x', '*'));
        ContextModel cm = ContextModel();
        result = e.evaluate(EvaluationType.REAL, cm).toString();
      }
    });
  }

  Color getTextColor(String s) {
    List<String> numbers = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.'
    ];
    List<String> operators = ['(', ')', '/', 'x', '+', '-', '='];
    List<String> clears = ['C', 'DE'];

    if (numbers.contains(s)) {
      return white;
    } else if (operators.contains(s)) {
      return green;
    } else if (clears.contains(s)) {
      return orange;
    }
    return white;
  }

}